<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helpers\CustomHelper as Helper;
use App\Services\Payment\BusinessLogicService;
use App\Services\Payment\ValidationService;
use App\Models\AppointmentPrice;
use App\Models\PaymentDetails;
use App\Models\Consultant;
use App\Models\Appointment;
use Stripe;

class PaymentController extends UtilityController
{
    protected $validationServiceObject;
    protected $businessLogicServiceObject;

    public function __construct()
    {
        $this->validationServiceObject = new ValidationService();
        $this->businessLogicServiceObject = new BusinessLogicService();
        parent::__construct();
    }

    public function getuser(Request $request){
       $isValidationFailed=$this->validationServiceObject->test($request->all());
       if ($isValidationFailed) {
        return response()->json($isValidationFailed, 400);
       }
       $apiResponse=$this->businessLogicServiceObject->detailById();
       
       $response = Helper::constructResponse(true,'Success',200,$apiResponse);
       return response()->json($response,400);
    }

    public function pricePlans(Request $request,$id){
      $formdata = $request->all();
        $apiResponse=$this->businessLogicServiceObject->getPricePlans($formdata,$id);
        // $response = Helper::constructResponse(false,'Success',200,$apiResponse);
        return response()->json($apiResponse,200);
     }

    
     public function stripe(){        
        return view('strip');
    }

    public function stripePost(Request $request)
    {
        $paymentDetailsObj = new PaymentDetails();
        $formData = $request->all();
        $userData = $request->user;
        $user_id = $userData->id;
        $consultation_id = $formData['consultation_id'];
        $appointment_id = $formData['appointment_id'];
        $stripeToken = $formData['stripeToken'];
        $price_id = $formData['price_id'];
        $price = $formData['price'];
        try{        
            

            $appointmentPriceObj = new AppointmentPrice();
            $price_details = $appointmentPriceObj->getPriceDetails($price_id);
            if(!$price_details){
                return Helper::constructResponse(true,'No price found',401,[]);
            }
            $db_price = $price_details->appointment_price;          
            if($db_price != $price){
                return Helper::constructResponse(true,'price not matched',401,[]);
            }
            $cent_price =  $db_price * 100;    
            $stripe_secret = config("app.stripe_secret");  
            $description = "Payment for Consultation ID: $consultation_id & Appointment ID: $appointment_id" ;              
            Stripe\Stripe::setApiKey($stripe_secret);
            $data = Stripe\Charge::create ([
                    "amount" => $cent_price,
                    "currency" => "usd",
                    "source" => $stripeToken,
                    "description" =>  $description  
            ]);
            $payment_response = json_encode($data);
            $transaction_id = $data['id'];
            $balance_transaction = $data['balance_transaction'];            
            
            $payment_data = array(
                "consultation_id" => $consultation_id,
                "appointment_id" => $appointment_id,
                "user_id" => $user_id,
                "amount" => $db_price,
                "transaction_id" => $transaction_id,
                "balance_transaction" => $balance_transaction,
                "status" => 1,
                "response" => $payment_response,
                "created_at" => date("Y-m-d H:i:s")
            );
            if($data['payment_method_details']){
                $payment_data['payment_type'] = $data['payment_method_details']['type'];
                if($data['payment_method_details']['card']){
                    $payment_data['card_brand'] = $data['payment_method_details']['card']['brand'];
                    $payment_data['card_num'] = $data['payment_method_details']['card']['last4'];
                }
            }           
            $paymentDetailsObj->save_data($payment_data);
            if(isset($appointment_id) && $appointment_id!='0'){
                $appointmentObj  = new Appointment();
                $appointmentObj->markAppointmentAsPaymentDone($appointment_id);
             }else{
                 $consultantObj = new Consultant();
                 $consultantObj->markConsultationAsPaymentDone($consultation_id);
             }
            return Helper::constructResponse(false,'payment done',200,$data);
        } catch (\Exception $e) {
            $payment_data = array(
                "consultation_id" => $consultation_id,
                "appointment_id" => $appointment_id,
                "user_id" => $user_id,
                "amount" => $price,                
                "status" => 0,                
                "created_at" => date("Y-m-d H:i:s")
            );
            $paymentDetailsObj->save_data($payment_data);                        
            return Helper::constructResponse(true,'Invalid payment details',401,[]);
        }
    }



}
