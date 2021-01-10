<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helpers\CustomHelper as Helper;
use App\Services\Payment\BusinessLogicService;
use App\Services\Payment\ValidationService;

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



}
