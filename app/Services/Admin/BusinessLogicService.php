<?php
namespace App\Services\Admin;
use App\Models\Consultant;
use App\Models\User;
use App\Models\Files;
use App\Models\QuesAnswerConsultant;
use App\Models\ConsultationProducts;
use App\Models\ConsultationNotes;

use App\Models\ProductImages;
use App\Models\Product;
use App\Models\ProductAssociatedTypes;
use App\Models\ProductAssociatedConcernMapping;
use App\Models\AdminAppointement;
use App\Models\Appointment;
use App\Models\Question;
use App\Models\QuestionOption;
use App\Models\PrmotionVideos;
use App\Models\StaticPageLinking;
use App\Models\StaticPages;
use App\Helpers\CustomHelper as Helper;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;
class BusinessLogicService
{
    public function __construct()
    {
    }

    public function getConsultationQueue($formData){
        $Consultant = Consultant::select('consultations.*','users.fname','users.lname','users.email','users.ethinicity','users.gender','date_of_birth')->join('users','users.id','consultations.user_id')
        ->where('users.profile_status','!=',2);
      
        //0 pending ,2 under review, 3 completed 
        if( $formData['consultantion_status'] == 1 ){
            $Consultant = $Consultant->where('consultations.consultant_status',1)->whereNull('consultations.car_report_response');
        }else if($formData['consultantion_status'] == 2){
            $Consultant = $Consultant->where('consultations.consultant_status',2)->whereNull('consultations.car_report_response');
        }elseif($formData['consultantion_status'] == 3){
            $Consultant = $Consultant->whereNotNull('consultations.car_report_response');
        }
        $Consultant =$Consultant ->orderBy('consultations.id','desc');
        if(isset($formData['search_by_text'])){
            $Consultant= $Consultant->where('users.fname','like','%'.$formData['search_by_text'].'%')
            ->orWhere('users.lname','like','%'.$formData['search_by_text'].'%')
            ->orWhere('consultations.id','like','%'.$formData['search_by_text'].'%');
        }
        if(isset($formData['page'])){
          
            $start_limit = ($formData['page'])*$formData['no_of_record'];
            $Consultant = $Consultant->offset($start_limit)->limit($formData['no_of_record']);
        }
        $Consultant=$Consultant->get();
        foreach($Consultant as $consult){
            $consult['age']=date_diff(date_create($consult['date_of_birth']), date_create('today'))->y;
            if($consult['gender'] == 'm'){
                $consult['gender'] = 'Male';
            }else if($consult['gender'] == 'f'){
                $consult['gender'] = 'Female';
            }else if($consult['gender'] == 't'){
                $consult['gender'] = 'Transgender';
            }else if($consult['gender'] == 'o'){
                $consult['gender'] = 'Others';
            }
        }
        $count =Consultant::join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status',$formData['consultantion_status'])->orderBy('consultations.id','desc')->get()->count();
        
        return Helper::constructResponse(false,'',200,['Consultant'=>$Consultant,'count'=>$count]);
    }

    public function consultationCount($formData){
      
        $pending =Consultant::join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status',1)->orderBy('consultations.id','desc')->get()->count();
        $under_review =Consultant::join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status',2)->orderBy('consultations.id','desc')->get()->count();
        $complete =Consultant::join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status',3)->orderBy('consultations.id','desc')->get()->count();
        
        return Helper::constructResponse(false,'',200,['pending'=>$pending,'under_review'=>$under_review,'complete'=>$complete]);
    }



    // public function getConsultationFullDetail($id){
    //     Consultant::where('id',$id)->where('consultant_status',1)->update([
    //         'consultant_status'=>2
    //     ]);
    //     $Consultant = DB::table('consultations')->select('consultations.*','users.fname','users.lname','users.email','users.ethinicity','users.gender','country_states.state_name','countries.country_name','users.zip_code')->join('users','users.id','consultations.user_id')->join('countries','users.country','countries.id')->join('country_states','country_states.id','users.state')
    //     ->where('consultations.id',$id)->orderBy('consultations.id','desc')->first();
    //     if( isset($Consultant->id)){
    //        $files= Files::where('consultation_id',$Consultant->id)->get();
    //        $Consultant->files=$files;
    //        $Consultant->ques_answer=array();
    //        $get_ques_answer_of_consultation = QuesAnswerConsultant::where('consultant_id',$Consultant->id)->orderBy('ques_id','asc')->orderBy('option_id','asc')->get();
    //        $index =0;
    //        foreach($get_ques_answer_of_consultation as $a=>$value){
    //            $is_present = false;
    //         if(count($Consultant->ques_answer) > 0){
    //             foreach($Consultant->ques_answer as $key=>$ques_ans){
    //                 if(array_search($value['ques_id'],$ques_ans)){
    //                     $is_present = true;
    //                    $Consultant->ques_answer[$key]['ques_answer'][] = $value['answer_for_admin'];
    //                 }
    //               }
    //               if(!$is_present){
    //                   $Consultant->ques_answer[$index]= array('ques_id'=>$value['ques_id'],
    //                 'ques_title'=>$value['question_for_admin'],'ques_answer'=>[$value['answer_for_admin']]);
    //               }
    //               $index++;
    //          }else{
    //             $Consultant->ques_answer= array(array('ques_id'=>$value['ques_id'],
    //             'ques_title'=>$value['question_for_admin'],'ques_answer'=>[$value['answer_for_admin']]));
    //          }
    //        }
    //     }else{
    //         $Consultant['files']=[];
    //         $Consultant['ques_answer']=[];
    //     }
    //     return Helper::constructResponse(false,'',200,['Consultant'=>$Consultant]);
    // }

    public function getConsultationFullDetail($id){
        // $user_id = $request->user->id;
        
        $consultations =Consultant::select('consultations.*','users.id as user_id','users.gender','users.fname','users.lname','users.date_of_birth','users.email','users.ethinicity','users.zip_code','countries.country_name',
        'country_states.state_name','users.address')
        ->join('users','users.id','consultations.user_id')
        ->leftjoin('countries','countries.id','users.country')
        ->leftjoin('country_states','country_states.id','users.state')
        ->where('consultations.id',$id)
        ->where('users.profile_status',1)->first();
        
        if($consultations && $consultations->consultant_status == 1){
            Consultant::where('id',$id)->where('consultant_status',1)
                ->update([
                        'consultant_status'=>2
                ]);
        }
        if($consultations){
            // if($consultations['consultant_status'] == 0){
            //     return Helper::constructResponse(false,'Consultation is not submitted successfully',200,[]);
            // }
            $consultations['name'] = $consultations->fname." ". $consultations->lname;
            $consultations['age'] = date_diff(date_create($consultations->date_of_birth), date_create('today'))->y;
            if($consultations->gender == 'f'){
                $consultations['gender']= "Female"; 
            }else if($consultations->gender == 'm'){
                $consultations['gender']= "Male";
            }else if($consultations->gender == 't'){
                $consultations['gender']= "Transgender";
            }else{
                $consultations['gender']= "Others";
            }
            $consultations['email']= $consultations->email;
            $consultations['car_report_response']=$consultations->car_report_response;
            $consultations['products']=[];
            $consultations['is_initial_meeting_done']=false;
            $consultations['is_followup_meeting_done']=false;
            $consultations['is_new_existing_meeting_done']=false;
            $initial_appointment = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('consultation_id',$id)
            ->where('appointment_type',1)->where('appointment_status','!=',2)->first();
            $followup_appointment = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('consultation_id',$id)
            ->where('appointment_type',2)->where('appointment_status','!=',2)->first();
            $new_on_existing = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('consultation_id',$id)
            ->where('appointment_type',3)->where('appointment_status','!=',2)->first();
            if($initial_appointment){
                $consultations['is_initial_meeting_done']=true;
            }
            if($followup_appointment){
                $consultations['is_followup_meeting_done']=true;
            }
            if($new_on_existing){
                $consultations['is_new_existing_meeting_done']=true;
            }

            if( $consultations['consultant_status'] == 3){
                $car_report_created_at = date('Y-m-d',strtotime($consultations['car_report_created_at']));
                // dd($car_report_created_at );
               $diff=date_diff(date_create('today'),date_create($car_report_created_at))->d;
                // $days =  $diff->format("%d days");
                $consultations['car_generated_days']=$diff;
            }else{
                $consultations['car_generated_days']=0;
            }
            $appointments=Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('consultation_id',$id)
            ->whereDate('appointment_date','>=',Carbon::now())->get();
            $consultations['appointments']=$appointments;
            $leftfiles= Files::where('consultation_id',$id)
            ->where('file_view_from',1)->get();
            $rightfiles= Files::where('consultation_id',$id)
            ->where('file_view_from',2)->get();
            $frontfiles= Files::where('consultation_id',$id)
            ->where('file_view_from',3)->get();
            $backfiles= Files::where('consultation_id',$id)
            ->where('file_view_from',4)->get();
            $consultations['leftfiles']=  $leftfiles;
            $consultations['rightfiles']=  $rightfiles;
            $consultations['frontfiles']=  $frontfiles;
            $consultations['backfiles']=  $backfiles;
            $consultations['products']=ConsultationProducts::join('products','products.id','consultation_products.product_id')
            ->where('consultation_products.consulation_id',$id)->where('consultation_products.status',1)->get();
            foreach($consultations['products'] as $product){
                $product_image = ProductImages::where('product_id',$product['product_id'])->get();
                $product['product_image']=$product_image;
                $product['concern']=ProductAssociatedConcernMapping::join('product_associated_types','product_associated_types.id','product_associated_concern_mapping.product_concern_id')
                ->where('product_associated_concern_mapping.product_id',$product['product_id'])->where('product_associated_types.associated_type',1)->get();
                $product['condition']=ProductAssociatedConcernMapping::join('product_associated_types','product_associated_types.id','product_associated_concern_mapping.product_concern_id')
                ->where('product_associated_concern_mapping.product_id',$product['product_id'])->where('product_associated_types.associated_type',2)->get();
            }
            //notes
            $consultations['notes']= ConsultationNotes::select('consultation_notes.id','consultation_notes.note_type','consultation_notes.condition_id','consultation_notes.consultation_note','consultation_notes.created_by','users.fname','users.lname')->leftjoin('users','users.id','consultation_notes.created_by')
            ->get();

            // getting consulation question 
            if($consultations['consultant_status'] == 1 || $consultations['consultant_status'] == 2 || $consultations['consultant_status'] == 3){
                $ques_answer=QuesAnswerConsultant::select('ques_id','option_id','question_for_admin','answer_for_admin','product_associated_type_id','id')->where('consultant_id',$consultations['id'])
                //->where('ques_answer_status',1)
                ->orderby('id','asc')
                ->get();
                $consultations['ques_answer']= $ques_answer;
            }else{
                $consultations['ques_answer']= [];
            }
            $msg = '';
            $status = false;
        }else{
            // $consultations['files']= []; 
            $msg = 'Details Not available';
            $status = true;
        }
        return Helper::constructResponse($status,$msg,200,['consultation_detail'=>$consultations]);

    }


    public function generateCar($formdata,$id){
        $consultation = Consultant::where('id',$id)->first(); 
        if($consultation->consultant_status == '3'){
            return Helper::constructResponse(true,'Car already generated',401,[]);
        }
        if($consultation->consultant_status == '0'){
            return Helper::constructResponse(true,'Consulation deatils not submitted successfully',401,[]);
        }
        $generate_car = Consultant::where('id',$id)->update([
            'car_report_response'=>$formdata['car_report_response'],
            'car_admin_remarks'=>$formdata['car_admin_remarks'],
            'consultant_status'=>3
        ]);
        // dd($form['products'] && count($form['products']) > 0);
        if(isset($formdata['products']) && count($formdata['products']) > 0){
         
            $form_prodcuts = $formdata['products'];
            ConsultationProducts::where('consulation_id',$id)->delete();
            foreach($form_prodcuts as $form_product){
                $product = new ConsultationProducts();
                $product->consulation_id = $id;
                $product->product_id = $form_product; 
                $product->save();
            }
        }
        if($generate_car){
            return Helper::constructResponse(false,'Car generated successfully',200,[]);
        }else{
            return Helper::constructResponse(false,'Car not generated successfully',401,[]);
        }
    }

    public function addConsultationNotes($formdata,$id,$user_id){
        $inserted_data = [
            'consultation_id'=>$id,
            'note_type'=>$formdata['note_type'],
            'condition_id'=>$formdata['condition_id'],
            'consultation_note'=>$formdata['consultation_note'],
            'created_by'=>$user_id
        ];
        ConsultationNotes::insert($inserted_data);
        return Helper::constructResponse(false,'Notes added successfully',200,[]);
    }

    
    public function getGeneratedCarDetail($user_detail,$id){
        $consultation = Consultant::where('id',$id)->first(); 
        $consultation->name= $user_detail->fname." ".$user_detail->lname;
    
        $age = date_diff(date_create($user_detail->date_of_birth), date_create('today'))->y;
        $consultation->name= $user_detail->fname." ".$user_detail->lname;
        $consultation->age=  $age;
        $consultation->gender=  $user_detail->gender;
        $consultation->ethinicity=  $user_detail->ethinicity;
        $consultation->condition=  $user_detail->condition;
    
        $product = ConsultationProducts::join('products','consultation_products.product_id','products.id')->where('consultation_products.consulation_id',$id)->get();
        if(count($product) > 0){
            foreach( $product as $p){
                $ps = ProductImages::where('product_id',$p['product_id'])->get();
                // dd($p['product_id']);
                $p['images']= $ps;
            }
        }
        $consultation->product = $product;
        $consultation->notes=ConsultationNotes::select('product_associated_types.*','consultation_notes.*','users.fname','users.lname','users.email')->join('product_associated_types','consultation_notes.condition_id','product_associated_types.id')->where('consultation_notes.consultation_id',$id)->join('users','users.id','consultation_notes.created_by')->orderBy('consultation_notes.id','desc')->get();
        
        return Helper::constructResponse(false,'',200, $consultation);
    }


    public function getUsersData($formData){
       $user=  User::select('users.id','users.date_of_birth','users.fname','users.lname','users.email','users.gender','users.gender','users.profile_status','users.profile_image')
       ->join('user_roles','users.id','user_roles.user_id')->join('roles','roles.id','user_roles.role_id');
       if(isset($formData['search_by_text']) && !empty($formData['search_by_text'])){
            $user= $user->where('users.fname','like','%'.$formData['search_by_text'].'%')
            ->orWhere('users.lname','like','%'.$formData['search_by_text'].'%');
        }
        $user= $user->where('roles.role_name','user')->where('users.profile_status',1)->orWhere('users.profile_status',2);
        if(isset($formData['page'])){
            $start_limit = ($formData['page'])*$formData['no_of_record'];
            $user = $user->offset($start_limit)->limit($formData['no_of_record']);
        }
       
        $user= $user->orderBy('users.id','desc')->get();
        foreach($user as $u){
            $u['age'] = date_diff(date_create($u['date_of_birth']), date_create('today'))->y;
            if($u['gender'] == 'f'){
                $u['gender']= "Female"; 
            }else if($u['gender'] == 'm'){
                $u['gender']= "Male";
            }else if($u['gender'] == 't'){
                $u['gender']= "Transgender";
            }else{
                $u['gender']= "Others";
            }
        }
       return Helper::constructResponse(false,'',200, $user);

    }


    public function getUserDetail($formData,$id){
        $user=  User::select('users.id','users.date_of_birth','users.fname','users.lname','users.email','users.gender','users.gender','users.profile_status','users.ethinicity','users.mobile_number','users.address','users.zip_code','users.profile_image','country_states.state_name','countries.country_name','countries.country_short_name')
        ->join('countries','countries.id','users.country') 
        ->join('country_states','country_states.id','users.state')->where('users.id',$id)->first();
        
        if($user){
            if($user->gender == 'f'){
                $user->gender= "Female"; 
            }else if($user->gender == 'm'){
                $user->gender= "Male";
            }else if($user->gender == 't'){
                $user->gender= "Transgender";
            }else{
                $user->gender= "Others";
            }
        }
      
        $cosultation= Consultant::where('user_id',$id)
        //->where('consultant_status','!=','0')
        ->where(function($query){
            return $query
            ->orWhere('consultations.consultant_status', '=', 1)
            ->orWhere('consultations.consultant_status', '=', 2)
            ->orWhere('consultations.consultant_status', '=', 3);
        })
        ->orderBy('id','desc')->get();
        if($user && $cosultation){
            $user->cosultation = $cosultation;
        }
        // $user= $user->orderBy('users.id','desc')->get();
        return Helper::constructResponse(false,'',200, $user);
 
     }

     public function updateProfileStatus($formData,$id){
        // if($formData['status'] != '1' && $formData['status']!='2'){
        //     return Helper::constructResponse(true,'changes not possible',401,[]);
        // }
        $isUpdated=User::where('id',$id)->update(['profile_status'=>$formData['status']]);
        if( $isUpdated){
            return Helper::constructResponse(false,'Status updated Successfully',200, []);
        }else{
            return Helper::constructResponse(false,'Status not updated',401, []);
        }
     }

     public function getConcernAndConditionType($formData){
        if(isset($formData['type'])){
            $product_asso_type=  ProductAssociatedTypes::where('associated_type',$formData['type'])->get();
        }else{
            $product_asso_type= ProductAssociatedTypes::get();
        }
     
        return Helper::constructResponse(true,'Status updated Successfully',200,$product_asso_type);
     }


     
     public function addProduct($formData){
        $product=new Product();
        $product->product_title =  $formData['product_title'];
        $product->product_url =  $formData['product_url'];
        $product->save();
        $product_associated_concern = $formData['product_associated_concern'];
        $product_associated_condition = $formData['product_associated_condition'];
        $combined_array = array_merge($product_associated_concern, $product_associated_condition);
        if(count($combined_array) > 0 ){
            foreach( $combined_array as $p_concern){
                $product_concern_map=new ProductAssociatedConcernMapping();
                $product_concern_map->product_id =$product->id ;
                $product_concern_map->product_concern_id =$p_concern;
                $product_concern_map->save();
            }
        }
        $product_images =  $formData['product_images'];
        if(count($product_images) > 0 ){
            foreach( $product_images as $p_images){
                $path = Storage::disk('s3')->put('Dev',$p_images);
                $product_image=new ProductImages();
                $product_image->product_image_url = config("app.aws_bucket_base_url").$path;
                $product_image->product_id = $product->id;
                $product_image->save();
            }
        }
     
        return Helper::constructResponse(true,'Product added Successfully',200,[]);
     }


     public function getProductByConcern($formData,$id){

        $extreme = Product::select('products.id','products.product_url','products.product_status','products.id','products.product_title','products.product_url')
        ->join('product_associated_concern_mapping as concern','concern.product_id','products.id')
        ->join('product_associated_concern_mapping as condition','condition.product_id','products.id');

        if(isset($formData['product_status']) && ($formData['product_status']== 1 || $formData['product_status']== 0)){
            $extreme=  $extreme->where('products.product_status',$id);
        }
        if(isset($formData['search_by_text']) && (!empty($formData['search_by_text']))){
            $extreme=  $extreme->where('products.product_title','like','%'.$formData['search_by_text'].'%');
        }
        $extreme= $extreme->where('concern.product_concern_id',$id)
        ->where('condition.product_concern_id',5)
        ->get();

        $moderate_extreme = Product::select('products.id','products.product_url','products.product_status','products.id','products.product_title','products.product_url')
        ->join('product_associated_concern_mapping as concern','concern.product_id','products.id')
        ->join('product_associated_concern_mapping as condition','condition.product_id','products.id');

        if(isset($formData['product_status']) && ($formData['product_status']== 1 || $formData['product_status']== 0)){
            $moderate_extreme=  $moderate_extreme->where('products.product_status',$id);
        }
        if(isset($formData['search_by_text']) && (!empty($formData['search_by_text']))){
            $moderate_extreme=  $moderate_extreme->where('products.product_title','like','%'.$formData['search_by_text'].'%');
        }
        $moderate_extreme= $moderate_extreme->where('concern.product_concern_id',$id)
        ->where('condition.product_concern_id',6)
        ->get();

        $low_extreme = Product::select('products.id','products.product_url','products.product_status','products.id','products.product_title','products.product_url')
        ->join('product_associated_concern_mapping as concern','concern.product_id','products.id')
        ->join('product_associated_concern_mapping as condition','condition.product_id','products.id');

        if(isset($formData['product_status']) && ($formData['product_status']== 1 || $formData['product_status']== 0)){
            $low_extreme=  $low_extreme->where('products.product_status',$id);
        }
        if(isset($formData['search_by_text']) && (!empty($formData['search_by_text']))){
            $low_extreme=  $low_extreme->where('products.product_title','like','%'.$formData['search_by_text'].'%');
        }
        $low_extreme= $low_extreme->where('concern.product_concern_id',$id)
        ->where('condition.product_concern_id',7)
        ->get();

        
        $nominal = Product::select('products.id','products.product_url','products.product_status','products.id','products.product_title','products.product_url')
        ->join('product_associated_concern_mapping as concern','concern.product_id','products.id')
        ->join('product_associated_concern_mapping as condition','condition.product_id','products.id');

        if(isset($formData['product_status']) && ($formData['product_status']== 1 || $formData['product_status']== 0)){
            $nominal=  $nominal->where('products.product_status',$id);
        }
        if(isset($formData['search_by_text']) && (!empty($formData['search_by_text']))){
            $nominal=  $nominal->where('products.product_title','like','%'.$formData['search_by_text'].'%');
        }
        $nominal= $nominal->where('concern.product_concern_id',$id)
        ->where('condition.product_concern_id',8)
        ->get();
        $products=['extreme'=>$extreme,'moderate_extreme'=>$moderate_extreme,
            'low_extreme'=>$low_extreme,'nominal'=>$nominal];
        $productsKey =['extreme','moderate_extreme','low_extreme','nominal'];
        for($i=0;$i<count($productsKey);$i++){
            $loopArray=$productsKey[$i];
            // dd($products[$loopArray]);
            foreach($products[$loopArray] as $key=>$product){
             
            $proImage= ProductImages::select('product_image_url')->where('product_id',$product['id'])->whereNotNull('product_image_url')->first();
            if($proImage){
                    $product['prdouct_image']=$proImage->product_image_url;
            }else{
                    $product['prdouct_image']='';
            }

            }
        }
        // dd( count($extreme));
        return Helper::constructResponse(false,'Product Detail fetched Successfully',200,$products);
        // $moderate_extreme = Product::select('products.id','products.product_title','products.product_url')->join('product_associated_concern_mapping as concern','concern.product_id','products.id')->join('product_associated_concern_mapping as condition','condition.product_id','products.id');
        
        // if(isset($formData['product_status']) && ($formData['product_status']== 1 || $formData['product_status']== 0)){
        //     $extreme=  $extreme->where('products.product_status',$id);
        // }
        // if(isset($formData['search_by_text']) && (!empty($formData['search_by_text']))){
        //     $extreme=  $extreme->where('products.product_title','like','%'.$formData['search_by_text'].'%');
        // }
        // $moderate_extreme= $moderate_extreme->where('concern.product_concern_id',$id)
        // ->where('condition.product_concern_id',6)->get();


        // $low_extreme = Product::select('products.id','products.product_title','products.product_url')->join('product_associated_concern_mapping as concern','concern.product_id','products.id')->join('product_associated_concern_mapping as condition','condition.product_id','products.id')
        // ->where('concern.product_concern_id',$id)
        // ->where('condition.product_concern_id',7)->get();
        // $nominal = Product::select('products.id','products.product_title','products.product_url')->join('product_associated_concern_mapping as concern','concern.product_id','products.id')->join('product_associated_concern_mapping as condition','condition.product_id','products.id')
        // ->where('concern.product_concern_id',$id)
        // ->where('condition.product_concern_id',8)->get();

        //  $condition_array[]= ['pat.associated_type','=','2'];
        //  if(isset($formData['product_status']) && $formData['product_status'] == '1' || $formData['product_status'] == '0'){
        //     $condition_array[]= ['products.product_status','=',$formData['product_status']];
        //  }
        // $all_condition_product = Product::join('product_associated_concern_mapping as pacm','products.id','pacm.product_id')
        // ->join('product_associated_types as pat','pat.id','pacm.product_concern_id')
        // ->where($condition_array);
        // if(isset($formData['search_by_text'])){
        //  $all_condition_product= $all_condition_product->where('products.product_title','like','%'.$formData['search_by_text'].'%')
        //     ->orWhere('pat.type_title','like','%'.$formData['search_by_text'].'%');
        // }
        
        // $all_condition_product= $all_condition_product->get();
        // $result=[];
        // $result['extreme']=[];
        // $result['moderate_extreme']=[];
        // $result['low_extreme']=[];
        // $result['nominal']=[];
        // foreach( $all_condition_product as $crp){
        //     $is_product_avaialble = Product::join('product_associated_concern_mapping','product_associated_concern_mapping.product_id','products.id')->where('product_associated_concern_mapping.product_id',$crp['product_id'])
        //     ->where('product_associated_concern_mapping.product_concern_id',$id)->first();
         
        //     if($is_product_avaialble){
        //         $product_images = ProductImages::where('product_id',$crp['product_id'])->get();
        //         $crp['product_images'] =$product_images;
        //       // dd( $crp['product_concern_id']);
        //         if($crp['product_concern_id'] == '5'){
        //             array_push($result['extreme'], $crp);
        //         }
        //         if($crp['product_concern_id'] == '6'){
        //             array_push($result['moderate_extreme'], $crp);
        //         }
        //         if($crp['product_concern_id'] == '7'){
        //             array_push($result['low_extreme'], $crp);
        //         }
        //         if($crp['product_concern_id'] == '8'){
        //             array_push($result['nominal'], $crp);
        //         }
        //     }

        // }
        // return Helper::constructResponse(false,'Product Detail fetched Successfully',200,$result);
     }

     public function updateProductStatus($formdata,$id){
       $status_update= Product::where('id',$id)->update(['products.product_status'=>$formdata['status']]);
       if( $status_update){
        return Helper::constructResponse(false,'Product status updated successfully',200,$status_update);
       }
     }

     
     public function getProductDetail($formdata,$id){
        $product= Product::where('id',$id)->first();
        if($product){
            $concern_type = ProductAssociatedConcernMapping::join('product_associated_types','product_associated_types.id','product_associated_concern_mapping.product_concern_id')->where('product_associated_concern_mapping.product_id',$id)
            ->where('product_associated_types.associated_type',1)->get();
            $condition_type = ProductAssociatedConcernMapping::join('product_associated_types','product_associated_types.id','product_associated_concern_mapping.product_concern_id')->where('product_associated_concern_mapping.product_id',$id)
            ->where('product_associated_types.associated_type',2)->get();
            $product['concern_type']= $concern_type ;
            $product['condition_type']= $condition_type ;
            $product_images = ProductImages::where('product_id',$id)->get();
            $product['product_images']= $product_images ;
        }
     
         return Helper::constructResponse(false,'',200,$product);
        
      }

      public function updateProductDetail($formData,$id){
        Product::where('id',$id)->update([
            'product_title'=>$formData['product_title'],
            'product_url'=>$formData['product_url']
        ]);
        ProductAssociatedConcernMapping::where('product_id',$id)->delete();
        $product_associated_concern = $formData['product_associated_concern'];
        $product_associated_condition = $formData['product_associated_condition'];
        $combined_array = array_merge($product_associated_concern, $product_associated_condition);
        if(count($combined_array) > 0 ){
            foreach( $combined_array as $p_concern){
                $product_concern_map=new ProductAssociatedConcernMapping();
                $product_concern_map->product_id =$id;
                $product_concern_map->product_concern_id =$p_concern;
                $product_concern_map->save();
            }
        }
        $product_images =  $formData['product_images'];
        if(count($product_images) > 0 ){
            foreach( $product_images as $p_images){
                $path = Storage::disk('s3')->put('Dev',$p_images);
                $product_image=new ProductImages();
                $product_image->product_image_url = config("app.aws_bucket_base_url").$path;
                $product_image->product_id = $id;
                $product_image->save();
            }
        }
     
        return Helper::constructResponse(true,'Product updated Successfully',200,[]);
     }

    public function deleteProductImage($id){
        $is_deleted=ProductImages::where('id',$id)->delete();
        if($is_deleted){
            return Helper::constructResponse(true,'Product image deleted Successfully',200,[]);
        }else{
            return Helper::constructResponse(true,'Product image not deleted ',401,[]);
        }
    }

    public function getProductRelatedConsulation($formData,$id){
        $Consultant = Consultant::select('consultations.*','users.fname','users.lname','users.email','users.ethinicity','users.gender','users.date_of_birth')->join('users','users.id','consultations.user_id')
        ->leftjoin('consultation_products','consultation_products.consulation_id','consultations.id')
        // ->where('consultations.consultant_status','!=','0')
        // ->where([
        //     ['consultations.consultant_status', '=',1],
        //     ['consultations.consultant_status', '=',2],
        //     ['consultations.consultant_status', '=',3],
        // ])
        ->where(function($query){
            return $query
            ->orWhere('consultations.consultant_status', '=', 1)
            ->orWhere('consultations.consultant_status', '=', 2)
            ->orWhere('consultations.consultant_status', '=', 3);
        })
        ->where('consultation_products.product_id',$id)
        ->orderBy('consultations.id','desc');
        
        if(isset($formData['page'])){
         
            $start_limit = ($formData['page'])*$formData['no_of_record'];
            $Consultant = $Consultant->offset($start_limit)->limit($formData['no_of_record']);
        }
        $Consultant=$Consultant->get();
        // dd($Consultant);
        foreach($Consultant as $consult){
            if($consult['gender'] == 'f'){
                $consult['gender']= "Female"; 
            }else if($consult['gender'] == 'm'){
                $consult['gender']= "Male";
            }else if($consult['gender'] == 't'){
                $consult['gender']= "Transgender";
            }else{
                $consult['gender']= "Others";
            }
            $consult['age'] = date_diff(date_create($consult['date_of_birth']), date_create('today'))->y;
        }
        // $count =Consultant::join('users','users.id','consultations.user_id')
        // ->where(function($query){
        //     return $query
        //     ->orWhere('consultations.consultant_status', '=', 1)
        //     ->orWhere('consultations.consultant_status', '=', 2)
        //     ->orWhere('consultations.consultant_status', '=', 3);
        // })
        // ->where('consultations.consultant_status','!=','0')
        // ->orderBy('consultations.id','desc')->get()->count();
        
        return Helper::constructResponse(false,'',200,['Consultant'=>$Consultant,'count'=>count($Consultant)]);
    }

    public function deleteProductById($formData,$id){
        $is_product_deleted = Product::where('id',$id)->delete();
        if($is_product_deleted){
            return Helper::constructResponse(true,'Product deleted successfully',200,[]);
        }else{
            return Helper::constructResponse(false,'Product not deleted',401,[]);
        }
    }


    public function addAdminAppointment($formData){
        $converted_time = date("H:i:s", strtotime($formData['appointment_time']));
        $end_time=  date("H:i:s", strtotime('+'.$formData['appointment_duration'].' minutes', strtotime($converted_time)));
        // $end_time=  date("H:i:s", strtotime('+10 minutes', strtotime($converted_time)));

        $insert_data = ['appointment_title'=>$formData['appointment_title'],'appointment_date'=>$formData['appointment_date'],'appointment_time'=>$converted_time,'appointment_type'=>$formData['appointment_type'],'appointment_duration'=>$formData['appointment_duration'],
        'appointment_end_time'=>$end_time,
        'created_at' => date("Y-m-d H:i:s")];
     
        $inserted= AdminAppointement::insert($insert_data);
        if($inserted){
            return Helper::constructResponse(false,'Appointment Scheduled sucessfully',200,[]);
        }else{
            return Helper::constructResponse(true,'Appointment not Scheduled',200,[]);
        }
    }

    public function getAppointmentDetail($formData,$id){

        if($formData['appointment_type'] == 'admin'){
            $appointment_detail= AdminAppointement::where('id',$id)->first();
            if( $appointment_detail){
                $appointment_detail->appointment_by = 'admin';
            }
        }
        if($formData['appointment_type'] == 'user'){
            $appointment_detail= Appointment::select('appointments.id','appointments.appointment_date','appointments.appointment_time','appointments.appointment_end_time','appointments.appointment_type','appointments.appointment_duration',DB::raw('CONCAT(users.fname," ",users.lname) AS fullname'))->join('users','users.id','appointments.user_id')->where('appointments.id',$id)->first();
        //     $appointment_detail=  Consultant::select('appointments.id','appointments.appointment_date','appointments.appointment_time','appointments.appointment_type','appointment_prices.appointment_duration','appointment_prices.appointment_type_name',DB::raw('CONCAT(users.fname," ",users.lname) AS fullname'),'appointments.created_at','appointments.updated_at')->join('appointments','appointments.consultation_id','consultations.id')->join('users','users.id','appointments.user_id')
        //    ->join('appointment_prices','appointment_prices.id','appointments.appointment_type')
        //     ->where('appointments.id',$id)->first();
            if($appointment_detail){
                $appointment_detail['appointment_title'] = 'Consultation meeting with '.$appointment_detail['fullname']; 
                $appointment_detail['appointment_by']= 'user';     
                unset($appointment_detail['fullname']); 
            }
           
        }
        if($appointment_detail){
            return Helper::constructResponse(false,'Appointment Scheduled sucessfully',200,$appointment_detail);
        }else{
            return Helper::constructResponse(true,'Appointment not Scheduled',200,[]);
        }
    }


    public function updateAppointmentStatus($formData,$id){

        if($formData['appointment_type'] == 'admin'){
            $appointment_detail= AdminAppointement::where('id',$id)->update([
                'appointment_status'=>$formData['status']
            ]);
        }
        if($formData['appointment_type'] == 'user'){
            
            $appointment_detail= Appointment::where('id',$id)->update([
                'appointment_status'=>$formData['status']
            ]);
           
        }
        if($appointment_detail){
            return Helper::constructResponse(false,'Appointment status changed sucessfully',200,$appointment_detail);
        }else{
            return Helper::constructResponse(true,'Appointment not Scheduled',200,[]);
        }
    }

    public function updateAdminAppointment($formData,$id){

        if($formData['appointment_by'] == 'admin'){
            $converted_time = date("H:i:s", strtotime($formData['appointment_time']));
            $update_data = [
                'appointment_title'=>$formData['appointment_title'],'appointment_date'=>$formData['appointment_date'],'appointment_time'=>$converted_time,
                'appointment_type'=>$formData['appointment_type'],
                'appointment_duration'=>$formData['appointment_duration'],
                'updated_at' => date("Y-m-d H:i:s")
            ];
            $appointment_detail= AdminAppointement::where('id',$id)->update($update_data);
        }
        if($formData['appointment_by'] == 'user'){
            $converted_time = date("H:i:s", strtotime($formData['appointment_time']));
            $update_data = [
                'appointment_date'=>$formData['appointment_date'],'appointment_time'=>$converted_time,
                'appointment_type'=>$formData['appointment_type'],
                'updated_at' => date("Y-m-d H:i:s")
            ];
            $appointment_detail= Appointment::where('id',$id)->update($update_data);
        }
        if($appointment_detail){
            return Helper::constructResponse(false,'Appointment status changed sucessfully',200,$appointment_detail);
        }else{
            return Helper::constructResponse(true,'Appointment not Scheduled',200,[]);
        }
    }


    // public function getAppointments($formData){

    //     if($formData['search_by'] == 'month' || $formData['search_by'] == 'week' || $formData['search_by'] == 'date'){
    //         if($formData['search_by'] == 'month'){
    //             $month = $formData['month'];
    //             $explode_array=explode("-",$month);
    //             $year = $explode_array[0];
    //             $mon = $explode_array[1];
    //             $admin_appointment = AdminAppointement::select('appointment_title','appointment_date','appointment_status','appointment_time','appointment_type','appointment_duration','id as appointment_id')->whereYear('appointment_date','=',$year)
    //                     ->whereMonth('appointment_date', '=',$mon)->where('appointment_status', '=',1)->get();
    //         }
    //         if($formData['search_by'] == 'week' || $formData['search_by'] == 'day'){
    //             $admin_appointment = AdminAppointement::select('appointment_title','appointment_status','appointment_date','appointment_time','appointment_type','appointment_duration','id as appointment_id')->whereBetween('appointment_date',[$formData['start_week'],$formData['end_week']])->where('appointment_status', '=',1)->get();
    //             // dd( $admin_appointment[0]['appointment_status']);
    //         }
            
    //          if(count($admin_appointment) > 0){
    //             foreach($admin_appointment as $app){
    //                 $str_time = strtotime($app['appointment_time']);
    //                 $app['appointment_by'] = 'admin';
    //                 $app['start_time'] = date("h:i A",$str_time);
    //                 $app['end_time'] = date("h:i A",strtotime("+".$app['appointment_duration']." minutes",$str_time));
    //             }
    //          }   
    //         if($formData['search_by'] == 'month'){
    //             // dd('ddd');
    //             $user_appointment = Appointment::select('appointments.appointment_date','appointments.appointment_time','appointments.appointment_type','appointment_prices.appointment_duration','appointments.id as appointment_id',
    //             DB::raw('CONCAT(users.fname," ",users.lname) AS fullname'))->join('appointment_prices','appointment_prices.id','appointments.appointment_status')->join('consultations','consultations.id','appointments.consultation_id')->join('users','users.id','appointments.user_id')->where('appointments.appointment_status', '=',1)
    //             ->whereYear('appointments.appointment_date','=',$year)
    //             ->whereMonth('appointments.appointment_date', '=',$mon)
    //            ->get();
    //         }
    //         if($formData['search_by'] == 'week'){
    //             $user_appointment = Appointment::select('appointments.appointment_date','appointments.appointment_status','appointments.appointment_time','appointments.appointment_type','appointment_prices.appointment_duration','appointments.id as appointment_id',
    //             DB::raw('CONCAT(users.fname," ",users.lname) AS fullname'))->join('appointment_prices','appointment_prices.id','appointments.appointment_status')->join('consultations','consultations.id','appointments.consultation_id')->join('users','users.id','appointments.user_id')->where('appointments.appointment_status', '!=',2)
    //             ->whereBetween('appointments.appointment_date',[$formData['start_week'],$formData['end_week']])->get();

    //         }
    //          if(count($user_appointment) > 0){
    //             foreach($user_appointment as $ua){
    //                 // dd($ua['appointment_status']);
    //                 $ua['appointment_title'] = 'Consultation meeting with '.$ua['fullname'];      
    //                 unset($ua['fullname']); 
    //                 $str_time = strtotime($ua['appointment_time']);
    //                 $ua['appointment_by'] = 'user';
    //                 $ua['start_time'] = date("h:i A",$str_time);
    //                 $ua['end_time'] = date("h:i A",strtotime("+".$app['appointment_duration']." minutes",$str_time));
    //                 // $ua['appointment_status']= $ua['appointment_status'];
    //                 $admin_appointment[count($admin_appointment)] = $ua;
                 
    //             }
    //          }  
    //          $result=[];
    //          if(count($admin_appointment) > 0){
    //             foreach( $admin_appointment as $ap=>$value){
    //                 if(count($result) > 0){
    //                     $is_presented = false;
    //                     foreach( $result as $key=>$r){
                            
    //                         if(isset($value['appointment_date']) && isset($r['appointment_date']) && strtotime($r['appointment_date']) == strtotime($value['appointment_date'])){
                       
    //                             $is_presented = true;
    //                             $result[$key]['data'][] = array('appointment_title'=> $value['appointment_title'],'appointment_date'=>$value['appointment_date'],'appointment_time'=>$value['appointment_time'],'appointment_type'=>$value['appointment_type'],'appointment_duration'=>$value['appointment_duration'],'appointment_id'=>$value['appointment_id'],
    //                             'appointment_by'=>$value['appointment_by'],
    //                             'start_time'=>$value['start_time'],
    //                             'end_time'=>$value['end_time']);
    //                         }
    //                     }
    //                     if(!$is_presented){
    //                        $count= count($result);
    //                         $result[$count]['appointment_date'] =  $value['appointment_date'];
    //                         $result[$count]['data'] = array('appointment_title'=> $value['appointment_title'],'appointment_date'=>$value['appointment_date'],'appointment_time'=>$value['appointment_time'],'appointment_type'=>$value['appointment_type'],'appointment_duration'=>$value['appointment_duration'],'appointment_id'=>$value['appointment_id'],
    //                         'appointment_by'=>$value['appointment_by'],
    //                         'start_time'=>$value['start_time'],
    //                         'end_time'=>$value['end_time']);
    //                     }
    //                 }else{
    //                     $result[0]['appointment_date'] = $value['appointment_date'];
    //                     $result[0]['data'][] = array('appointment_title'=> $value['appointment_title'],'appointment_date'=>$value['appointment_date'],'appointment_time'=>$value['appointment_time'],'appointment_type'=>$value['appointment_type'],'appointment_duration'=>$value['appointment_duration'],'appointment_id'=>$value['appointment_id'],
    //                     'appointment_by'=>$value['appointment_by'],
    //                     'start_time'=>$value['start_time'],
    //                     'end_time'=>$value['end_time']);
    //                 }
    //             }
    //          }
        
    //          return Helper::constructResponse(false,'',200,$result);    
           
    //     }
   
    // }

    public function getAppointments($formData){

        if($formData['search_by'] == 'month' || $formData['search_by'] == 'week' || $formData['search_by'] == 'date'){
            if($formData['search_by'] == 'month'){
                $month = $formData['month'];
                $explode_array=explode("-",$month);
                $year = $explode_array[0];
                $mon = $explode_array[1];
                $admin_appointment = DB::table('admin_appointments')->select('appointment_title','appointment_date','appointment_status','appointment_time','appointment_end_time','appointment_type','id as appointment_id')->whereYear('appointment_date','=',$year)
                ->whereMonth('appointment_date', '=',$mon)
                ->where(function($query){
                    return $query
                    ->orWhere('appointment_status', '=', 1)
                    ->orWhere('appointment_status', '=', 3);
                   
                })->get();
                $user_appointemnt = DB::table('appointments')->select('appointment_date','appointment_status','appointment_end_time','appointment_time','appointment_type','id as appointment_id')->whereYear('appointment_date','=',$year)
                ->whereMonth('appointment_date', '=',$mon)
                ->where(function($query){
                    return $query
                    ->orWhere('appointment_status', '=', 1)
                    ->orWhere('appointment_status', '=', 3);
                   
                })->get();
                $index = count($admin_appointment);
              
                for($i=1;$i<=count($user_appointemnt);$i++){
                    $admin_appointment[$index]= $user_appointemnt[$i-1];
                    $index=$index+1;
                }
            
            }
            if($formData['search_by'] == 'week' || $formData['search_by'] == 'day'){
                $admin_appointment = DB::table('admin_appointments')->select('appointment_title','appointment_date','appointment_status','appointment_time','appointment_end_time','appointment_type','id as appointment_id')
                ->whereBetween('appointment_date',[$formData['start_week'],$formData['end_week']])
                ->where(function($query){
                    return $query
                    ->orWhere('appointment_status', '=', 1)
                    ->orWhere('appointment_status', '=', 3);
                   
                })->get();
              
                $user_appointemnt = DB::table('appointments')->select('appointment_date','appointment_status','appointment_end_time','appointment_time','appointment_type','id as appointment_id')
                ->whereBetween('appointment_date',[$formData['start_week'],$formData['end_week']])
                ->where(function($query){
                    return $query
                    ->orWhere('appointment_status', '=', 1)
                    ->orWhere('appointment_status', '=', 3);
                   
                })
                //->where('appointment_status', '=',1)
                ->get();
                $index = count($admin_appointment);
              
                for($i=1;$i<=count($user_appointemnt);$i++){
                    $admin_appointment[$index]= $user_appointemnt[$i-1];
                    $index=$index+1;
                }
             
            }
            
            foreach($admin_appointment as $value){
              
                if(isset($value->appointment_title)){
                    $value->appointment_by = 'admin';
                }else{
                    $value->appointment_by = 'user';
                    $userdata=DB::table('appointments')->select('users.fname','users.lname')->join('users','appointments.user_id','users.id')->first();
                    // dd($userdata);
                    $value->appointment_title = 'Consultation meeting with '.$userdata->fname;
                }
            }
             return Helper::constructResponse(false,'',200,$admin_appointment);
        }
    }

    public function addQuestion($formData){
       
        $ques = new Question();
        $ques->ques_title = $formData['ques_title'];
        $ques->ques_option_type = $formData['ques_option_type'];
        $ques->is_last_question = 1;
        $ques->is_use_existing_car=$formData['is_use_existing_car'];
        $ques->ques_status = 1;
        $ques->from_age_condition=$formData['from_age_condition'];
        $ques->to_age_condition	=$formData['to_age_condition'];
        $ques->save();
        $orderQuestion=Question::where('ques_parent_option_id','0')->orderBy('ques_ordering_id','desc')
        ->first();
        if($orderQuestion){
            $order_id = $orderQuestion->ques_ordering_id +1;
        }else{
            $order_id = 1;
        }
        $inserted_data= Question::find( $ques->id);
        $inserted_data->ques_ordering_id = $order_id;
        
        $inserted_data->save();
        if($ques->id){
            Question::where('id','!=',$ques->id)->update([
                'is_last_question'=>0
            ]);

            $question_options = $formData['question_option'];
            if(isset($formData['option_check_condition_id'])){
                $option_check_condition_id = $formData['option_check_condition_id'];
            }else{
                $option_check_condition_id = [0];
            }
           
            $condition_id=implode(",",$option_check_condition_id);
            foreach($question_options as $question_option){
                $new_ques_option = new QuestionOption();
                //dd( $question_option);
                if($formData['ques_option_type']== '8'){
                    $new_ques_option->option_image = $question_option['value'];
                }else{
                    // $new_ques_option->option_title = settype($question_option['value'],'string');
                    $new_ques_option->option_title = $question_option['value'];
                }
             
                $new_ques_option->option_ques_id = $ques->id;
                $new_ques_option->option_status = 1;
                if(isset($formData['option_check_condition_id']) && count($formData['option_check_condition_id']) > 0){
                    $new_ques_option->option_check_condition_id = $condition_id;
                }else{
                    $new_ques_option->option_check_condition_id =0;
                }
                
                $new_ques_option->product_associated_type_id =$question_option['type_id'];
                $new_ques_option->created_at =date("Y-m-d H:i:s");
                // $new_ques_option->option_status = 1;
                $new_ques_option->save();
            }
        }
        if($ques){
            return Helper::constructResponse(false,'Question added Successfully',200,[]);    
        }

    }

    public function getQuestionDetail($formData,$ques_id){
       $question=Question::where('id',$ques_id)->first();
       if(!$question){
        return Helper::constructResponse(true,'No Question are available',401,[]);
       }
       $option= QuestionOption::where('option_ques_id',$ques_id)->where('option_status',1)->get();
       return Helper::constructResponse(false,'',200,['ques'=>$question,'option'=> $option]);
    }

    public function deleteQuesOption($formData,$option_id){
        $option_updated= QuestionOption::where('id',$option_id)->update(['option_status'=>'0']);
        if($option_updated){
            return Helper::constructResponse(false,'Option Deleted Successfully',200,[]);
        }
    }
 
    public function editQuestion($formData,$ques_id){
        $question = Question::find($ques_id);
        if(!$question){
            return Helper::constructResponse(true,'question not available',200,[]);
        }
        // dd($formData['ques_option_type']);
        $question->ques_title = $formData['ques_title'];
        $question->ques_option_type = $formData['ques_option_type'];
        $question->is_use_existing_car=$formData['is_use_existing_car'];
        $question->from_age_condition=$formData['from_age_condition'];
        $question->to_age_condition	=$formData['to_age_condition'];
        $question->save();
        $question_options = $formData['question_option'];
        $condition_id=implode(",",$formData['option_check_condition_id']);
        foreach($question_options as $question_option){
            $update_data=[];
            if($formData['ques_option_type'] == '8'){
                $update_data['option_image'] = $question_option['value'];
            }else{
                $update_data['option_title'] = $question_option['value'];
                $update_data['option_image'] = '';
            }
            $update_data['option_check_condition_id'] = $condition_id;
            $update_data['product_associated_type_id'] =$question_option['type_id'];
            $update_data['updated_at'] =date("Y-m-d H:i:s");
            $update_data['option_ques_id'] = $ques_id;
            if( $question_option['is_new'] == 'false'){
                // $ques_option = QuestionOption::find($question_option['option_id']);
                // $update_data=[];
                $ques_option=QuestionOption::where('id',$question_option['option_id'])->update($update_data);
              
            }else{
                $update_data['created_at']= date("Y-m-d H:i:s");
                $ques_option=QuestionOption::insert($update_data);
                // $ques_option = new QuestionOption();
            }  
          
        }
        if($ques_option){
            return Helper::constructResponse(false,'Option updated Successfully',200,[]);
        }
    }

    public function updateVideo($formData){
        $updatedata=[];
        $updatedata['video_title'] = $formData['video_title'];
        $updatedata['video_level'] = $formData['video_level'];
        if(isset($formData['video_file']) && !empty($formData['video_file'])){
            $path = Storage::disk('s3')->put('Dev',$formData['video_file']);
            $updatedata['video_url'] = config("app.aws_bucket_base_url").$path;
        }
        $updatedata['updated_at'] = date("Y-m-d H:i:s");
        if($formData['video_level'] == '2'){
            $updatedata['play_after_ques_id'] =$formData['play_after_ques_id'];
        }
        $prom_video=PrmotionVideos::where('video_level',$updatedata['video_level'])->first();
        if($prom_video){
            $in_inserted=PrmotionVideos::where('video_level',$updatedata['video_level'])->update($updatedata);

        }else{
            $updatedata['created_at'] = date("Y-m-d H:i:s");
            $in_inserted=PrmotionVideos::insert($updatedata);
        }
        if($in_inserted){
            return Helper::constructResponse(false,'Video updated Successfully',200,[]);
        }else{
            return Helper::constructResponse(true,'Video not updated Successfully',200,[]);
        }

    }

    public function getPromVideo($formData){
        if(isset($formData['video_level'])){
            $prom_video=PrmotionVideos::where('video_level',$formData['video_level'])->get();
        }else{
            $prom_video= PrmotionVideos::get();
        }
     
       return Helper::constructResponse(true,'',200,$prom_video);
    //    if($prom_video){
      
    //    }
    }

    public function getStaticPagesDetails($formData){
        $static_pages=StaticPages::get();
        if($static_pages){
         return Helper::constructResponse(true,'',200,$static_pages);
        }
    }

    public function getStaticPageDetails($formData,$id){
        $static_page=StaticPages::where('id',$id)->first();
        if($static_page){
            $static_page_linking = StaticPageLinking::where('static_page_id',$id)->get();
            foreach($static_page_linking as $spl){
                if($spl['option_id']){
                    $ques_option = QuestionOption::where('id',$spl['option_id'])
                    ->where('option_status',1)->first();
                    if($ques_option['option_ques_id']){
                        $ques = Question::where('id',$ques_option['option_ques_id'])
                        ->where('ques_status',1)->first();
                        $option = QuestionOption::where('option_ques_id',$ques_option['option_ques_id'])->get();
                        $spl['question']= $ques;
                       
                        foreach($option as $op){
                            if($op['id'] == $spl['option_id']){
                                $op['is_selected'] = true;
                            }else{
                                $op['is_selected'] = false;
                            }
                        }
                        $spl['question_option']= $option;
                        
                    }
                   

                }
                if($spl['question_id']){
                    $ques = Question::where('id',$spl['question_id'])
                    ->where('ques_status',1)->first();
                    $option = QuestionOption::where('option_ques_id',$ques_option['option_ques_id'])->get();
                    $spl['question']= $ques;
                    $spl['question']= $ques;
                    $spl['question_option']= [];
                }
            }
         return Helper::constructResponse(true,'',200,$static_page_linking);
        }else{
            return Helper::constructResponse(true,'',200,[]);
        }
    }

    public function addStaticPages($formData){
        $static_pages = new StaticPages();
        $static_pages->page_title = $formData['page_title'];
        $static_pages->page_content = $formData['page_content'];
        $static_pages->created_at =  date("Y-m-d H:i:s");
        $static_pages->updated_at =  date("Y-m-d H:i:s");
        $static_pages->save();
        foreach($formData['question'] as $question){
            if($question['ques_id']){
                $static_page_link = new StaticPageLinking();
                $static_page_link->static_page_id = $static_pages['id'];
                $static_page_link->question_id = $question['ques_id'];
                $static_page_link->save();
            }
            if($question['option_id']){
                $static_page_link = new StaticPageLinking();
                $static_page_link->static_page_id = $static_pages['id'];
              
                $static_page_link->option_id = $question['option_id'];
                $static_page_link->save();
            }
        }
        return Helper::constructResponse(true,'Static pages added successfully',200,[]);
    }

    public function deleteStaticPage($id){
        $statPage=StaticPages::where('id',$id)->delete();
        if($statPage){
            StaticPageLinking::where('static_page_id',$id)->delete();
            return Helper::constructResponse(false,'Static pages deleted successfully',200,[]);
        }else{
            return Helper::constructResponse(true,'',200,[]);
        }
    }

    public function getRootLevelQuestion($formData){
       $ques= Question::where('ques_parent_option_id','0')
        ->orderBy('ques_ordering_id','asc')->get();
        return Helper::constructResponse(false,'Question list Found successfully',200,[$ques]);

    }

    public function updateQuestionLinking($formData){
        $ques_id = $formData['ques_id'];
        $option_id = $formData['option_id'];
        $update_data =[];
        if($option_id){
            $update_data['ques_parent_option_id'] = $option_id;
        }
        if($option_id == '0'){
            $question_detail = Question::where('id',$formData['above_ques_id'])->first();
            $all_question_lists = Question::where('ques_ordering_id','>',$question_detail->ques_ordering_id)
            ->where('ques_parent_option_id','0')
            ->where('id','!=',$ques_id)
            ->orderBy('ques_ordering_id','asc')->get();
            $question_order_id = $question_detail->ques_ordering_id+1;
            $updated_question = Question::find($formData['ques_id']);
            if($question_detail){
                $order_id = $question_detail->ques_ordering_id + 1 ;
                $updated_question->ques_ordering_id = $order_id;
            }else{
                $order_id = 1;
                $updated_question->ques_ordering_id = 1;
            }
            $updated_question->ques_parent_option_id = 0;
            $updated_question->save();
            foreach($all_question_lists as $all_question_list){
                $order_id = $order_id+1;
                $change_order_id = Question::find($all_question_list['id']);
                $change_order_id->ques_ordering_id = $order_id;
                $change_order_id->save();
            }
            
            $is_updated = true;
        }else{
            $max_order_id= Question::where('ques_parent_option_id',$option_id)
            ->where('id','!=',$ques_id)
            ->orderBy('ques_ordering_id','desc')->first();
            if($max_order_id){
                $order_id=  $max_order_id->ques_ordering_id + 1;
            }else{
                $order_id= 1;
            }
            $update_data['ques_ordering_id'] = $order_id;
            $is_updated= Question::where('id',$ques_id)
            ->update($update_data);
        }
        if($is_updated){
            return Helper::constructResponse(false,'Question seqencing updated ',200,[]);
        }else{
            return Helper::constructResponse(true,' ',200,[]);
        }
     }


     public function getQuesLinkingQuestions($formData){
        $base_questions=DB::table('ques')->where('ques_parent_option_id','0')->orderBy('ques_ordering_id','asc')->get();
       foreach($base_questions as $base_question){
         
           $question_options =  DB::table('ques_options')->where('option_ques_id',$base_question->id)->orderBy('id','asc')->get();
           foreach($question_options as $question_option){
             $ques_exist_status =$this->in_option_ques_exist($question_option);
             if($ques_exist_status){
                $option_ques =$this->get_ques($question_option);
                foreach($option_ques as $option_que){
                    $get_ques_option =$this->get_ques_option($option_que);
                    $option_que->option = $get_ques_option;
                }
                $question_option->ques=$option_ques;
             }else{
                $question_option->ques=[];
             }
           }
           $base_question->option = $question_options;
       }
       return Helper::constructResponse(false,'Question seqencing updated ',200,$base_questions);
     }

     public function in_option_ques_exist($details){
        $is_exist=DB::table('ques')->where('ques_parent_option_id',$details->id)->orderBy('id','asc')->first();
        return $is_exist ?  true: false; 
     }

     public function get_ques($option){
        $ques=DB::table('ques')->where('ques_parent_option_id',$option->id)->orderBy('id','asc')->get();
        return $ques; 
     }

    public function get_ques_option($data){
        $option= DB::table('ques_options')->where('option_ques_id',$data->id)->orderBy('id','asc')->get();
        return $option; 
    }

    public function deleteQuestion($ques_id){
        $ques=DB::table('ques')->where('id',$ques_id)->delete();
        if($ques){
            $option= DB::table('ques_options')->where('option_ques_id',$ques_id)->delete();
           
            return Helper::constructResponse(false,'Question deleted',200,[]);
        }else{
            return Helper::constructResponse(true,'Question not found',401,[]);
        }
       
    }

    public function recommendedProducts($fromData){
        if(isset($fromData['condition_id'])){
            $query = Product::select('products.id','products.product_title','products.product_url')->join('product_associated_concern_mapping as concern','concern.product_id','products.id')->join('product_associated_concern_mapping as condition','condition.product_id','products.id')
            ->where('concern.product_concern_id',$fromData['concern_id'])
            ->where('condition.product_concern_id',$fromData['condition_id'])->get();
            // dd($query);
        }else{
            $query = Product::select('products.id','products.product_title','products.product_url')->join('product_associated_concern_mapping as concern','concern.product_id','products.id')->where('concern.product_concern_id',$fromData['concern_id'])->get();
        }
        foreach( $query as $value){
           
            $productimages= ProductImages::select('product_image_url')->where('id',$value['id'])->first();
            if($productimages){
                $value['product_images'] =  $productimages->product_image_url;
            }else{
                $value['product_images'] = '';
            }
        }
        return Helper::constructResponse(false,'',200,$query);
    }




    public function uploadImage($formData){
        $path = Storage::disk('s3')->put('Questions',$formData['images']);
        $path = config("app.aws_bucket_base_url").$path;
        return Helper::constructResponse(false,'Uploaded',200,['path'=>$path]);
    }



}
