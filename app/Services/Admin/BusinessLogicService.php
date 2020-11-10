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
use App\Helpers\CustomHelper as Helper;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
class BusinessLogicService
{
    public function __construct()
    {
    }

    public function getConsultationQueue($formData){
        $Consultant = Consultant::select('consultations.*','users.fname','users.lname','users.email','users.ethinicity')->join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status',$formData['consultantion_status'])->orderBy('consultations.id','desc');
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
        $count =Consultant::join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status',$formData['consultantion_status'])->orderBy('consultations.id','desc')->get()->count();
        
        return Helper::constructResponse(false,'',200,['Consultant'=>$Consultant,'count'=>$count]);
    }

    public function getConsultationFullDetail($id){
        Consultant::where('id',$id)->where('consultant_status',1)->update([
            'consultant_status'=>2
        ]);
        $Consultant = DB::table('consultations')->select('consultations.*','users.fname','users.lname','users.email','users.ethinicity','users.gender','country_states.state_name','countries.country_name','users.zip_code')->join('users','users.id','consultations.user_id')->join('countries','users.country','countries.id')->join('country_states','country_states.id','users.state')
        ->where('consultations.id',$id)->orderBy('consultations.id','desc')->first();
        if( isset($Consultant->id)){
           $files= Files::where('consultation_id',$Consultant->id)->get();
           $Consultant->files=$files;
           $Consultant->ques_answer=array();
           $get_ques_answer_of_consultation = QuesAnswerConsultant::where('consultant_id',$Consultant->id)->orderBy('ques_id','asc')->orderBy('option_id','asc')->get();
           $index =0;
           foreach($get_ques_answer_of_consultation as $a=>$value){
               $is_present = false;
            if(count($Consultant->ques_answer) > 0){
                foreach($Consultant->ques_answer as $key=>$ques_ans){
                    if(array_search($value['ques_id'],$ques_ans)){
                        $is_present = true;
                       $Consultant->ques_answer[$key]['ques_answer'][] = $value['answer_for_admin'];
                    }
                  }
                  if(!$is_present){
                      $Consultant->ques_answer[$index]= array('ques_id'=>$value['ques_id'],
                    'ques_title'=>$value['question_for_admin'],'ques_answer'=>[$value['answer_for_admin']]);
                  }
                  $index++;
             }else{
                $Consultant->ques_answer= array(array('ques_id'=>$value['ques_id'],
                'ques_title'=>$value['question_for_admin'],'ques_answer'=>[$value['answer_for_admin']]));
             }
           }
        }else{
            $Consultant['files']=[];
            $Consultant['ques_answer']=[];
        }
        return Helper::constructResponse(false,'',200,['Consultant'=>$Consultant]);
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

    public function addConsultationNotes($formdata,$id){
        $inserted_data = [
            'consultation_id'=>$id,
            'note_type'=>$formdata['note_type'],
            'condition_id'=>$formdata['condition_id'],
            'consultation_note'=>$formdata['consultation_note'],
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
       $user=  User::select('users.id','users.fname','users.lname','users.email','users.gender','users.gender','users.profile_status')
       ->join('user_roles','users.id','user_roles.user_id')->join('roles','roles.id','user_roles.role_id');
       if(isset($formData['search_by_text'])){
            $user= $user->where('users.fname','like','%'.$formData['search_by_text'].'%')
            ->orWhere('users.lname','like','%'.$formData['search_by_text'].'%');
          
        }
        $user= $user->where('roles.role_name','user')->where('users.profile_status',1)->orWhere('users.profile_status',2);
        if(isset($formData['page'])){
            $start_limit = ($formData['page'])*$formData['no_of_record'];
            $user = $user->offset($start_limit)->limit($formData['no_of_record']);
        }
       
        $user= $user->orderBy('users.id','desc')->get();
       return Helper::constructResponse(false,'',200, $user);

    }


    public function getUserDetail($formData,$id){
        $user=  User::select('users.id','users.fname','users.lname','users.email','users.gender','users.gender','users.profile_status','users.ethinicity','users.mobile_number','users.address','users.zip_code','users.profile_image','country_states.state_name','countries.country_name','countries.country_short_name')
        ->join('countries','countries.id','users.country') 
        ->join('country_states','country_states.id','users.state')->where('users.id',$id)->first();
        $cosultation= Consultant::where('user_id',$id)->where('consultant_status','!=','0')->orderBy('id','desc')->get();
        $user->cosultation = $cosultation; 
        // $user= $user->orderBy('users.id','desc')->get();
        return Helper::constructResponse(false,'',200, $user);
 
     }

     public function updateProfileStatus($formData,$id){
        if($formData['status'] != '1' && $formData['status']!='2'){
            return Helper::constructResponse(true,'changes not possible',401,[]);
        }
        $isUpdated=User::where('id',$id)->update(['profile_status'=>$formData['status']]);
        if( $isUpdated){
            return Helper::constructResponse(true,'Status updated Successfully',200, []);
        }else{
            return Helper::constructResponse(true,'Status not updated',401, []);
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
         $condition_array[]= ['pat.associated_type','=','2'];
         if(isset($formData['product_status']) && $formData['product_status'] == '1' || $formData['product_status'] == '0'){
            $condition_array[]= ['products.product_status','=',$formData['product_status']];
         }
        $all_condition_product = Product::join('product_associated_concern_mapping as pacm','products.id','pacm.product_id')
        ->join('product_associated_types as pat','pat.id','pacm.product_concern_id')
        ->where($condition_array);
        if(isset($formData['search_by_text'])){
         $all_condition_product= $all_condition_product->where('products.product_title','like','%'.$formData['search_by_text'].'%')
            ->orWhere('pat.type_title','like','%'.$formData['search_by_text'].'%');
        }
        
        $all_condition_product= $all_condition_product->get();
        $result=[];
        $result['extreme']=[];
        $result['moderate_extreme']=[];
        $result['low_extreme']=[];
        $result['nominal']=[];
        foreach( $all_condition_product as $crp){
            $is_product_avaialble = Product::join('product_associated_concern_mapping','product_associated_concern_mapping.product_id','products.id')->where('product_associated_concern_mapping.product_id',$crp['product_id'])
            ->where('product_associated_concern_mapping.product_concern_id',$id)->first();
         
            if($is_product_avaialble){
                $product_images = ProductImages::where('product_id',$crp['product_id'])->get();
                $crp['product_images'] =$product_images;
              // dd( $crp['product_concern_id']);
                if($crp['product_concern_id'] == '5'){
                    array_push($result['extreme'], $crp);
                }
                if($crp['product_concern_id'] == '6'){
                    array_push($result['moderate_extreme'], $crp);
                }
                if($crp['product_concern_id'] == '7'){
                    array_push($result['low_extreme'], $crp);
                }
                if($crp['product_concern_id'] == '8'){
                    array_push($result['nominal'], $crp);
                }
            }

        }
        return Helper::constructResponse(true,'Product Detail fetched Successfully',200,$result);
     }

     public function updateProductStatus($formdata,$id){
       $status_update= Product::where('id',$id)->update(['products.product_status'=>$formdata['status']]);
       if( $status_update){
        return Helper::constructResponse(true,'Product status updated successfully',200,$status_update);
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
     
         return Helper::constructResponse(true,'',200,$product);
        
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
        $Consultant = Consultant::select('consultations.*','users.fname','users.lname','users.email','users.ethinicity')->join('users','users.id','consultations.user_id')
        ->join('consultation_products','consultation_products.consulation_id','consultations.id')
        ->where('consultations.consultant_status','!=','0')
        ->where('consultation_products.product_id',$id)
        ->orderBy('consultations.id','desc');
        
        if(isset($formData['page'])){
         
            $start_limit = ($formData['page'])*$formData['no_of_record'];
            $Consultant = $Consultant->offset($start_limit)->limit($formData['no_of_record']);
        }
        $Consultant=$Consultant->get();
        $count =Consultant::join('users','users.id','consultations.user_id')
        ->where('consultations.consultant_status','!=','0')
        ->orderBy('consultations.id','desc')->get()->count();
        
        return Helper::constructResponse(false,'',200,['Consultant'=>$Consultant,'count'=>$count]);
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
        $insert_data = ['appointment_title'=>$formData['appointment_title'],'appointment_date'=>$formData['appointment_date'],'appointment_time'=>$converted_time,'appointment_type'=>$formData['appointment_type'],'appointment_duration'=>$formData['appointment_duration'],
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
        }
        if($formData['appointment_type'] == 'user'){
            $appointment_detail=  Consultant::select('appointments.id','appointments.appointment_date','appointments.appointment_time','appointments.appointment_type','appointment_prices.appointment_duration','appointment_prices.appointment_type_name',DB::raw('CONCAT(users.fname," ",users.lname) AS fullname'),'appointments.created_at','appointments.updated_at')->join('appointments','appointments.consultation_id','consultations.id')->join('users','users.id','appointments.user_id')
           ->join('appointment_prices','appointment_prices.id','appointments.appointment_type')
            ->where('appointments.id',$id)->first();
            if($appointment_detail){
                $appointment_detail['appointment_title'] = 'Consultation meeting with '.$appointment_detail['fullname'];      
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
            $appointment_detail= AdminAppointement::where('id',$id)->update( $update_data);
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


    public function getAppointments($formData){

        if($formData['search_by'] == 'month' || $formData['search_by'] == 'week'){
            if($formData['search_by'] == 'month'){
                $month = $formData['month'];
                $explode_array=explode("-",$month);
                $year = $explode_array[0];
                $mon = $explode_array[1];
                $admin_appointment = AdminAppointement::select('appointment_title','appointment_date','appointment_time','appointment_type','appointment_duration','id as appointment_id')->whereYear('appointment_date','=',$year)
                        ->whereMonth('appointment_date', '=',$mon)->where('appointment_status', '!=',2)->get();
            }
            if($formData['search_by'] == 'week' || $formData['search_by'] == 'day'){
                $admin_appointment = AdminAppointement::select('appointment_title','appointment_date','appointment_time','appointment_type','appointment_duration','id as appointment_id')->whereBetween('appointment_date',[$formData['start_week'],$formData['end_week']])->where('appointment_status', '!=',2)->get();

            }
            
             if(count($admin_appointment) > 0){
                foreach($admin_appointment as $app){
                    $str_time = strtotime($app['appointment_time']);
                    $app['appointment_by'] = 'admin';
                    $app['start_time'] = date("h:i A",$str_time);
                    $app['end_time'] = date("h:i A",strtotime("+".$app['appointment_duration']." minutes",$str_time));
                }
             }   
            if($formData['search_by'] == 'month'){
                // dd('ddd');
                $user_appointment = Appointment::select('appointments.appointment_date','appointments.appointment_time','appointments.appointment_type','appointment_prices.appointment_duration','appointments.id as appointment_id',
                DB::raw('CONCAT(users.fname," ",users.lname) AS fullname'))->join('appointment_prices','appointment_prices.id','appointments.appointment_status')->join('consultations','consultations.id','appointments.consultation_id')->join('users','users.id','appointments.user_id')->where('appointments.appointment_status', '!=',2)
                ->whereYear('appointments.appointment_date','=',$year)
                ->whereMonth('appointments.appointment_date', '=',$mon)
               ->get();
            }
            if($formData['search_by'] == 'week'){
                $user_appointment = Appointment::select('appointments.appointment_date','appointments.appointment_time','appointments.appointment_type','appointment_prices.appointment_duration','appointments.id as appointment_id',
                DB::raw('CONCAT(users.fname," ",users.lname) AS fullname'))->join('appointment_prices','appointment_prices.id','appointments.appointment_status')->join('consultations','consultations.id','appointments.consultation_id')->join('users','users.id','appointments.user_id')->where('appointments.appointment_status', '!=',2)
                ->whereBetween('appointments.appointment_date',[$formData['start_week'],$formData['end_week']])->get();

            }
             if(count($user_appointment) > 0){
                foreach($user_appointment as $ua){
                    $ua['appointment_title'] = 'Consultation meeting with '.$ua['fullname'];      
                    unset($ua['fullname']); 
                    $str_time = strtotime($ua['appointment_time']);
                    $ua['appointment_by'] = 'user';
                    $ua['start_time'] = date("h:i A",$str_time);
                    $ua['end_time'] = date("h:i A",strtotime("+".$app['appointment_duration']." minutes",$str_time));
                    $admin_appointment[count($admin_appointment)] = $ua;
                 
                }
             }  
             $result=[];
             if(count($admin_appointment) > 0){
                foreach( $admin_appointment as $ap=>$value){
                    if(count($result) > 0){
                        $is_presented = false;
                        foreach( $result as $key=>$r){
                            
                            if(isset($value['appointment_date']) && isset($r['appointment_date']) && strtotime($r['appointment_date']) == strtotime($value['appointment_date'])){
                       
                                $is_presented = true;
                                $result[$key]['data'][] = array('appointment_title'=> $value['appointment_title'],'appointment_date'=>$value['appointment_date'],'appointment_time'=>$value['appointment_time'],'appointment_type'=>$value['appointment_type'],'appointment_duration'=>$value['appointment_duration'],'appointment_id'=>$value['appointment_id'],
                                'appointment_by'=>$value['appointment_by'],
                                'start_time'=>$value['start_time'],
                                'end_time'=>$value['end_time']);
                            }
                        }
                        if(!$is_presented){
                           $count= count($result);
                            $result[$count]['appointment_date'] =  $value['appointment_date'];
                            $result[$count]['data'] = array('appointment_title'=> $value['appointment_title'],'appointment_date'=>$value['appointment_date'],'appointment_time'=>$value['appointment_time'],'appointment_type'=>$value['appointment_type'],'appointment_duration'=>$value['appointment_duration'],'appointment_id'=>$value['appointment_id'],
                            'appointment_by'=>$value['appointment_by'],
                            'start_time'=>$value['start_time'],
                            'end_time'=>$value['end_time']);
                        }
                    }else{
                        $result[0]['appointment_date'] = $value['appointment_date'];
                        $result[0]['data'][] = array('appointment_title'=> $value['appointment_title'],'appointment_date'=>$value['appointment_date'],'appointment_time'=>$value['appointment_time'],'appointment_type'=>$value['appointment_type'],'appointment_duration'=>$value['appointment_duration'],'appointment_id'=>$value['appointment_id'],
                        'appointment_by'=>$value['appointment_by'],
                        'start_time'=>$value['start_time'],
                        'end_time'=>$value['end_time']);
                    }
                }
             }
        
             return Helper::constructResponse(false,'',200,$result);    
           
        }
   
    }


}
