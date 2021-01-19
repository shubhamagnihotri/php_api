<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\UtilityController;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helpers\CustomHelper as Helper;
use App\Models\User;
use App\Models\Question;
use App\Models\QuestionOption;
use App\Models\QuesCondition;
use App\Models\Consultant;
use App\Models\QuesAnswerConsultant;
use App\Models\Files;
use App\Models\Appointment;
use App\Models\AdminAppointement;
use App\Models\AppointmentPrice;
use App\Models\Product;
use App\Models\ConsultationProducts;
use App\Models\ProductAssociatedConcernMapping;
use App\Models\ProductAssociatedConditionMapping;
use App\Models\ProductAssociatedTypes;
use App\Models\ProductImages;
use Carbon\Carbon;
use DateTime;
use Illuminate\Support\Facades\DB;
use Validator;
class QuestionnaireController extends UtilityController
{
    //

    public function getQuestionAndSubmitAnswer(Request $request){
        if ($request->isMethod('get')) {
            // $response=$this->getFirstQuestion($request);
            $response = $this->getNextQuestion(0,0,0,$request->user);
            return response()->json($response);
        }
        if ($request->isMethod('post')) {
            // getting next question 
            // if($request->input('ques_step') == 'next'){
            //     $response= $this->submitQuestionAnswerGetQues($request->all(),$request->user);
            // }
            $formdata = $request->all();
            $consultation_id = $formdata['consultation_id'];

            
            if(empty($formdata['consultation_id'])){
                
                $consultation_id = $this->generateConsultationId($request->user->id);                       
            }
            $question_option = $this->submitQuestionForm($request->all(),$request->user,$consultation_id);
           

            $question_id = $question_option['question_id'];
            $option_id =  $question_option['option_id'];

            $response = $this->getNextQuestion($question_id,$option_id,$consultation_id, $request->user);
           
            return response()->json($response);
        }
    }


    // This is a recursive function for getting the next question if condition is not appllied
    public function checkNextQuestionWithCondition($questions,$age,$gender_id)
    {                
        $quesObj = new Question();
        $optionObj = new QuestionOption(); 
        if($questions){
            if($questions->condition_type){
                $condition_array = explode(",",$questions->condition_type);             
                if(in_array(1,$condition_array))  //1: Gender; 2: Age  
                {                
                    $gender_array = explode(",",$questions->gender_id);                 
                    if(!in_array($gender_id,$gender_array))
                    {                   
                        $questionid = $questions->id;
                        $question = $quesObj->getNextQuestionionId($questionid);
                        $next_ques_id = $question->next_question_id;               
                        $questions = $quesObj->getQuestionDetails($next_ques_id); 
                        $questions =  $this->checkNextQuestionWithCondition($questions,$age,$gender_id);
                    }
                }                       
            }
        }       
        
        return $questions;
    }//eo checkNextQuestionWithCondition()


    // This function returns the next question of provided id
    // 0 for first question
    public function getNextQuestion($questionid = 0,$option_id = 0,$consultation_id = 0,$userData)
    {       
        $gender_code = $userData->gender;
        $dob = $userData->date_of_birth;       
        $age = $this->getAgeFromDOB($dob);
        $gender_id =1;// $this->getGenderIdByShortCode($gender_code);        
        
        $quesObj = new Question();
        $optionObj = new QuestionOption();
        $questions = array();

        if($questionid == 0)
        {           
            $questions = $quesObj->getFirstQuestion();
        }
        else{
            
            if($option_id !=0)
            {
                $questions = $quesObj->isChildQuestionOfOption($option_id);
            }
            if(!$questions)
            {
                $question = $quesObj->getNextQuestionionId($questionid);
                $next_ques_id = $question->next_question_id;               
                $questions = $quesObj->getQuestionDetails($next_ques_id);   
            }                              
        }                  
        $questions = $this->checkNextQuestionWithCondition($questions,$age,$gender_id);
        $option=array();
        if($questions){
            $option=$this->getOptionsOfQuestionId($questions->id);
        }
        
                
        return Helper::constructResponse(false,'',200,['ques'=>$questions,'option'=> $option,'consultation_id'=>$consultation_id]);
    }

    //returns the option list of given question id;
    public function getOptionsOfQuestionId($question_id){
        $quesObj = new Question();
        $optionObj = new QuestionOption();
        $option= $optionObj->getOptionOfQuestion($question_id);
        if(count($option) > 0){
            foreach($option as $opt){               
                $is_sub_ques =$quesObj->isChildQuestionOfOption($opt['id']);                               
                if($is_sub_ques){                   
                    $opt['is_sub_ques_exist'] = $is_sub_ques->is_sub_question;;
                }else{
                    $opt['is_sub_ques_exist'] = 0;
                }
            }           
       }
       return  $option;
    }
    

    // get first question and option start
    // public function getFirstQuestion($formdata){

    //     $quesObj = new Question();
    //     $optionObj = new QuestionOption();
    //     $ques = $quesObj->getFirstQuestion();        
    //     if(!$ques){
    //         return Helper::constructResponse(true,'No Question are available',401,[]);
    //     }
    //    $option= $optionObj->getOptionOfQuestion($ques->id);    
    //    if(count($option) > 0){
    //         foreach($option as $opt){
    //             $is_sub_ques =$quesObj->isChildQuestionOfOption($opt['id']);
    //             if($is_sub_ques){
    //                 $opt['is_sub_ques_exist'] = true;
    //             }else{
    //                 $opt['is_sub_ques_exist'] = false;
    //             }
    //         }
    //    }
    //    return Helper::constructResponse(false,'',200,['ques'=>$ques,'option'=> $option,'consultation_id'=>'']);
    // }
    // get first question and option end



     // get Question Details
    public function getQuestionDetails($id){

        $quesObj = new Question();
        $optionObj = new QuestionOption();
        $ques = $quesObj->getQuestionDetails($id);       
        if(!$ques){
            return Helper::constructResponse(true,'No Question are available',401,[]);
        }
        $option=$this->getOptionsOfQuestionId($ques->id);
       return Helper::constructResponse(false,'',200,['ques'=>$ques,'option'=> $option,'consultation_id'=>'']);
    }
    // eo getQuestionDetails

    // Returns the new generated consulted id
    public function generateConsultationId($user_id){
        $consultation_data = new Consultant();
        $consultation_data->user_id = $user_id;
        $consultation_data->consultant_created_at = date("Y-m-d H:i:s");
        $consultation_data->consultant_status = 0;
        $consultation_data->created_at = date("Y-m-d H:i:s");
        $consultation_data->save();
        return $consultation_data->id;
    }//eo generateConsultationId()

    //this function save the answers and 
    public function submitQuestionForm($formdata,$userData,$consultation_id)
    {
        $quesObj = new Question();
        $optionObj = new QuestionOption();
        $parent_question_id = 0;
        $option_id = 0;
        foreach($formdata['submit_data'] as $form){  
                    
            $ques_detail = $quesObj->getQuestionDetails($form['ques_id']);              
            if(!$ques_detail->is_sub_question)
            {
                $parent_question_id = $ques_detail->id;
            }    
            $answer_id_string  = 0;
            $answer_string =   $form['ques_answer'][0];            
            if($ques_detail->ques_option_type == '1' || $ques_detail->ques_option_type == '2')   
            {
                $answerid_array = array();
                $answer_string_array = array();
                foreach($form['ques_answer'] as $answer){
                    if($ques_detail->ques_option_type == '1'){
                        $option_id = $answer;
                        $opt_ques = $quesObj->isChildQuestionOfOption($answer);
                        if($opt_ques){                            
                            if($opt_ques->is_sub_question){
                                $option_id = 0;
                            }
                        }
                        
                    }
                    $answerid_array[] = $answer;
                    $get_option_detail= QuestionOption::where('id',$answer)->first();                    
                    if($get_option_detail->option_title){
                        $answer_string_array[] = $get_option_detail->option_title;                        
                    }                    
                }
                $answer_id_str = implode(",",$answerid_array) ;
                $answer_string = implode(",",$answer_string_array) ;
            } 
            $QuesAnswerConsult = new QuesAnswerConsultant();
            $QuesAnswerConsult->ques_id = $ques_detail->id;
            $QuesAnswerConsult->option_id = $answer_id_str; 
            $QuesAnswerConsult->question_for_admin= $ques_detail->ques_title;
            $QuesAnswerConsult->answer_for_admin= $answer_string;
            $QuesAnswerConsult->consultant_id = $consultation_id; 
            $QuesAnswerConsult->save();
        };
        $return_data = array('question_id'=>$parent_question_id,"option_id"=>$option_id);        
        return $return_data;
    }//eo submitQuestionForm();

    // submit question answer and get next question (Next question )start
    // public function submitQuestionAnswerGetQues($formdata,$userData){
    //     $all_ques_array = array_column($formdata['submit_data'],'ques_id');
    //     echo "<pre>";
    //     print_r($all_ques_array);
    //     die();
    //     if(empty($formdata['consultation_id'])){
    //     // 
    //         $all_ques_array = array_column($formdata['submit_data'],'ques_id');
           
    //     //    if(!in_array(1,$all_ques_array)){
    //     //     return Helper::constructResponse(true,'please provide all params',400,[]);
    //     //    }
    //        $consultation_data = new Consultant();
    //        $consultation_data->user_id = $userData->id;
    //        $consultation_data->consultant_created_at = date("Y-m-d H:i:s");
    //        $consultation_data->consultant_status = 0;
    //        $consultation_data->created_at = date("Y-m-d H:i:s");
    //        $consultation_data->save();
    //       $formdata['consultation_id'] = $consultation_data->id;
    //     }
    //     $all_ques_array = array_column($formdata['submit_data'],'ques_id');
    //     $max_ques_id = max($all_ques_array);
    //     $max_ques_options = null;
    //     foreach($formdata['submit_data'] as $form){
    //         $ques_detail = Question::where('id',$form['ques_id'])->first();
        
    //         $consultOption =QuesAnswerConsultant::where('ques_id',$form['ques_id'])->where('consultant_id',$formdata['consultation_id'])->get();
    //         QuesAnswerConsultant::where('ques_id',$form['ques_id'])->where('consultant_id',$formdata['consultation_id'])->delete();
    //         if($form['ques_id'] == $max_ques_id){
    //             $max_ques_options = count($form['ques_answer']) == 1? $form['ques_answer'][0]:$form['ques_answer'][0];
    //         }
    //         foreach($form['ques_answer'] as $answer){
    //             $get_option_detail= QuestionOption::where('id',$answer)->first();
    //             $QuesAnswerConsult = new QuesAnswerConsultant();
    //             $QuesAnswerConsult->ques_id = $form['ques_id'];
    //             $QuesAnswerConsult->option_id = $answer; 
    //             if($ques_detail->ques_title){
    //                 $QuesAnswerConsult->question_for_admin= $ques_detail->ques_title;
    //             }
    //             if($get_option_detail->option_title){
    //                 $QuesAnswerConsult->answer_for_admin= $get_option_detail->option_title;
    //             }
    //             $QuesAnswerConsult->consultant_id = $formdata['consultation_id']; 
    //             $QuesAnswerConsult->save();
    //         }
    //     }

    //     if($formdata['is_last_question'] == 'true'){
    //         $consult_status=Consultant::where('id',$formdata['consultation_id'])->where('user_id',$userData->id)->update([
    //             'consultant_status'=>4,
    //             'consultant_ended_at'=>date("Y-m-d H:i:s")
    //         ]);
    //         $res = ['ques'=>[],'option'=> [],'is_final_ques_submitted'=>false,'link'=>'','consultation_id'=> $formdata['consultation_id']];
    //         if($consult_status){
    //             $res['is_final_ques_submitted'] = true;
    //         }
    //         return Helper::constructResponse(false,'Option not available',401,$res);
    //     }
    //     if($max_ques_options != null){
    //         $option = QuestionOption::where('id',$max_ques_options)->where('option_status',1)->first();
    //         if($option && $option->option_link){
    //             return Helper::constructResponse(false,'',200,['ques'=>[],'option'=> [],'link'=>$option->option_link,'consultation_id'=> $formdata['consultation_id']]);
    //         }
    //         if(!$option){
    //             return Helper::constructResponse(true,'Option not available',401,[]);
    //         }
    //         if($option->option_check_condition_id != '0'){
    //             $checkingConditionsId = explode(",",$option->option_check_condition_id);
    //             $checkingConditions= QuesCondition::whereIn('id', $checkingConditionsId)->get();
    //             $includedGender =[];
                 
    //             foreach($checkingConditions as $conditions){
    //                 if($conditions['condition_title'] != 'Age'){
    //                     $includedGender[] = $conditions['condition_code'];
    //                 }else{
    //                     $checkAge = $conditions['condition_code'];
    //                 }
    //             }
    //             if(count($includedGender) > 0 && isset($checkAge)){
    //                 // dd('dd 1');
    //                 $age = date_diff(date_create($request->user->date_of_birth), date_create('today'))->y;
    //                 if(in_array($request->user->gender,$includedGender) && $age > $checkAge){
    //                     $next_ques_id = $option->option_condition_true_next_question_id;
    //                 }else{
    //                     $next_ques_id = $option->option_condition_false_next_question_id;
    //                 }
               
    //             }else if(count($includedGender) > 0 && !isset($checkAge)){
                   
    //                 if(in_array($request->user->gender,$includedGender)) {
    //                     $next_ques_id = $option->option_condition_true_next_question_id;
    //                 }else{
    //                     $next_ques_id = $option->option_condition_false_next_question_id;
    //                 }
                  
    //             }else if(count($includedGender) == 0 && isset($checkAge)){
    //                 // dd('dd 3');
    //                 $age = date_diff(date_create($request->user->date_of_birth), date_create('today'))->y;
    //                 if($age > $checkAge){
    //                     $next_ques_id = $option->option_condition_true_next_question_id;
    //                 }else{
    //                     $next_ques_id = $option->option_condition_false_next_question_id;
    //                 }
    //             }
    //             $ques = Question::where('id',$next_ques_id )->where('ques_status',1)->first();
    //             if(!$ques){
    //                 return Helper::constructResponse(true,'No Question are available',401,[]);
    //             }
    //             $option= QuestionOption::where('option_ques_id',$ques->id)->where('option_status',1)->get();
    //             return Helper::constructResponse(false,'',200,['ques'=>$ques,'option'=> $option,'link'=>'']);

    //         }// option_check_condition_id == 0

    //         // when no conditions
    //         if($option->option_check_condition_id == 0){
    //             $ques = Question::where('ques_parent_option_id',$max_ques_options)->where('ques_status',1)->first();
    //            if(!$ques){
    //             $max_ques_id = $max_ques_id+1;
    //             $ques = Question::where('id',$max_ques_id)->where('ques_status',1)->first();
    //            }
    //             if($ques){
    //                 $option= QuestionOption::where('option_ques_id',$ques->id)->where('option_status',1)->get();
    //                 if(count($option) > 0){
    //                     foreach($option as $opt){
                           
    //                         $is_sub_ques = Question::where('ques_parent_option_id',$opt['id'])->where('ques_status',1)->where('is_sub_question',1)->first();
                          
    //                         if($is_sub_ques){
    //                             $opt['is_sub_ques_exist'] = true;
    //                         }else{
    //                             $opt['is_sub_ques_exist'] = false;
    //                         }
    //                     }
    //                 }
    //                 return Helper::constructResponse(false,'',200,['ques'=>$ques,'option'=> $option,'consultation_id'=> $formdata['consultation_id']]);
    //             }
    //         }

    //     }// max ques option != null
      
    // }
    // submit question answer and get next question (Next question )end



       

    // chcek and get subquestion of question start
    public function checkAndGetSubQuestion(Request $request){
        // dd($request->user->id);
      if(empty($request->input('ques_id')) || count($request->input('option_ids')) == 0) {
        return Helper::constructResponse(true,'please provide all require params',401,[]);
      }
      $ques_id = $request->input('ques_id');
      $option_ids = $request->input('option_ids');
      $option = QuestionOption::where('id',$option_ids[0])->where('option_status',1)->first();
      if(!$option){
        return Helper::constructResponse(true,'Option not available',401,[]);
      }
       $ques = Question::where('ques_parent_option_id',$option_ids[0])->where('ques_status',1)->where('is_sub_question',1)->first();
       
       if($ques){
        $option= QuestionOption::where('option_ques_id',$ques->id)->where('option_status',1)->get();
        if(count($option) > 0){
            foreach($option as $opt){
               
                $is_sub_ques = Question::where('ques_parent_option_id',$opt['id'])->where('ques_status',1)->where('is_sub_question',1)->first();
              
                if($is_sub_ques){
                    $opt['is_sub_ques_exist'] = true;
                }else{
                    $opt['is_sub_ques_exist'] = false;
                }
            }
       }
       
        return Helper::constructResponse(false,'',200,['ques'=>$ques,'option'=> $option]);
       }
     
    }
    // chcek and get subquestion of question end


    //start get consultaion detail 
    public function getConsultaionDetail(Request $request){
        $user_id = $request->user->id;
        $consultations=Consultant::where('user_id',$user_id)->orderBy('id','desc');
        if($request->input('page_number')){
            $no_of_record = 3;
            $page_number = $request->input('page_number');
            $start_limit = ($page_number*$no_of_record);
            $consultations = $consultations->offset($start_limit)->limit($no_of_record);
        }
        $consultations=$consultations->get();
       foreach($consultations as $consult){
           if(($consult['consultant_status']  == 4 || $consult['consultant_status']  == 2) && !empty($consult['car_report_response'])){ 
            $days= date_diff(date_create(date_format($consult['consultant_created_at'],'Y-m-d')), date_create('today'))->d;
            // if($days <= 9){
            //     $consult['is_less_than_10_days'] = true;
            // }else{
            //     $consult['is_less_than_10_days'] = true;
            // }
            $consult['is_less_than_10_days']= $days <= 9? true:false;
            $consult['is_between_10_90_days']= ($days >= 10 && $days <=89)? true:false;
            $consult['is_more_than_90_days']= ($days >= 90)? true:false;
           }else{
            $consult['is_less_than_10_days'] = false;
            $consult['is_between_10_90_days'] = false;
            $consult['is_more_than_90_days'] = false;
           }
           if($consult['consultant_status'] == 0){
            $consult['next_question_id']= $this->get_next_question($consult['id']);
           }else{
            $consult['next_question_id'] = null;
           }
            $files= Files::where('user_id',$user_id)->where('consultation_id',$consult['id'])->get();
            $consult['files']=  $files;
       }
       return Helper::constructResponse(false,'',200,['consultation_detail'=>$consultations]);
    }

     //start get consultaion detail 
    public function getSheduledAppointments(Request $request){
        $shedule_appointment = Consultant::join('appointments','consultations.id','appointments.consultation_id')
        ->where('appointments.appointment_status','!=','2')->whereIn('consultations.consultant_status',[1,2])->get();
        return Helper::constructResponse(false,'',200,$shedule_appointment);
    }
    

    //end get consultaion detail 
    //start get consultaion full detail 
    public function getConsultaionFullDetail(Request $request,$id){
        $user_id = $request->user->id;
        $consultations =Consultant::where('user_id',$user_id)->where('id',$id)->first();
        if($consultations){
            if($consultations['consultant_status'] == 0){
                return Helper::constructResponse(false,'Consultation is not submitted successfully',200,[]);
            }
            if(($consultations['consultant_status']  == 4 || $consultations['consultant_status']  == 2) && !empty($consultations['car_report_response'])){ 
                $days= date_diff(date_create(date_format($consultations['consultant_created_at'],'Y-m-d')), date_create('today'))->d;
                // if($days <= 9){
                //     $consult['is_less_than_10_days'] = true;
                // }else{
                //     $consult['is_less_than_10_days'] = true;
                // }
                $consultations['is_less_than_10_days']= $days <= 9? true:false;
                $consultations['is_between_10_90_days']= ($days >= 10 && $days <=89)? true:false;
                $consultations['is_more_than_90_days']= ($days >= 90)? true:false;
               }else{
                $consultations['is_less_than_10_days'] = false;
                $consultations['is_between_10_90_days'] = false;
                $consultations['is_more_than_90_days'] = false;
               }
               if($consultations['consultant_status'] == 0){
                $consultations['next_question_id']= $this->get_next_question($consultations['id']);
               }else{
                $consultations['next_question_id'] = null;
               }
            $consultations['name'] = $request->user->fname." ". $request->user->lname;
            $consultations['age'] = date_diff(date_create($request->user->date_of_birth), date_create('today'))->y;
            if($request->user->gender == 'f'){
                $consultations['gender']= "Female"; 
            }else if($request->user->gender == 'm'){
                $consultations['gender']= "Male";
            }else if($request->user->gender == 't'){
                $consultations['gender']= "Transgender";
            }else{
                $consultations['gender']= "Others";
            }
            $consultations['email']= $request->user->email;
            $consultations['car_report_response']=$consultations->car_report_response;
            $consultations['products']=[];
            $consultations['is_initial_meeting_done']=false;
            $consultations['is_followup_meeting_done']=false;
            $consultations['is_new_existing_meeting_done']=false;
            $initial_appointment = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('user_id',$user_id)->where('consultation_id',$id)
            ->where('appointment_type',1)->where('appointment_status','!=',2)->first();
            $followup_appointment = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('user_id',$user_id)->where('consultation_id',$id)
            ->where('appointment_type',2)->where('appointment_status','!=',2)->first();
            $new_on_existing = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('user_id',$user_id)->where('consultation_id',$id)
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
            $appointments=Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('user_id',$user_id)->where('consultation_id',$id)
            ->whereDate('appointment_date','>=',Carbon::now())->get();
            $consultations['appointments']=$appointments;
            $files= Files::where('user_id',$user_id)->where('consultation_id',$id)->get();
            $consultations['files']=  $files;
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
            $msg = '';
            $status = false;
        }else{
            // $consultations['files']= []; 
            $msg = 'Details Not available';
            $status = true;
        }
        return Helper::constructResponse($status,$msg,200,['consultation_detail'=>$consultations]);

    }
    //start get consultaion full detail 

    // add consultaion feedback 
    public function addConsultationFeedback(Request $request){
        $validation['rules'] = [
            'consultation_id' => ['required'],
            'feedback_text'=>['required']
        ];
        $validation['messages'] = [
            'consultation_id.required' => 'Consultation id is required',
            'feedback_text.required' => 'Feedback is required',
        ];
        $validation =  Validator::make($request->all(),$validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        $update_data = ['feedback_rating'=>$request->input('feedback_rating'),'feedback_text'=>$request->input('feedback_text')];
       $update_data= Consultant::where('id',$request->input('consultation_id'))->update($update_data);
       if($update_data){
        return Helper::constructResponse(false,'',200,['feedback_rating'=>$request->input('feedback_rating'),'feedback_text'=>$request->input('feedback_text')]);
       }else{
        return Helper::constructResponse(true,'',200,[]);
       }
    }

    public function addConsultationAppointment(Request $request){
        $validation['rules'] = [
            'appointment_date' => ['required'],
            'appointment_time'=>['required'],
            'appointment_type'=>['required'],
            'consultation_id'=>['required']
        ];
        $validation['messages'] = [
            'appointment_date.required' => 'Appointment date is required',
            'appointment_time.required' => 'Appointment Time is required',
            'appointment_type.required' => 'Please provide all params',
            'consultation_id.required' => 'Please provide all params',
        ];
        $validation =  Validator::make($request->all(),$validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        $converted_time = date("H:i:s", strtotime($request->input('appointment_time')));
        $insert_data = ['appointment_date'=>$request->input('appointment_date'),'appointment_time'=>$converted_time,'appointment_type'=>$request->input('appointment_type'),'consultation_id'=>$request->input('consultation_id'),
        'user_id'=>$request->user->id];
     
        $inserted= Appointment::insert($insert_data);
        if($inserted){
            return Helper::constructResponse(false,'Appointment Scheduled sucessfully',200,[]);
        }else{
            return Helper::constructResponse(true,'Appointment not Scheduled',200,[]);
        }
    }


    // getting available slots 
    public function getConsultationSlots(Request $request){
      
        $validation['rules'] = [
            'appointment_date' => ['required'],
            'appointment_type'=>['required']
        ];
        $validation['messages'] = [
            'appointment_date.required' => 'Appointment date is required',
            'appointment_type.required' => 'Appointment Type is required',
        ];
        $validation =  Validator::make($request->all(),$validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        $date = $request->input('appointment_date');
        $type = $request->input('appointment_type');
        $appointment_time = AppointmentPrice::where('id',$type)->first();
        if(!$appointment_time){
            return Helper::constructResponse(true,'Something went wrong',200,[]);
        }
        $start_time= config("app.appointment_start_time");
        $end_time=config("app.appointment_end_time");
        $slots = $this->getSlots($appointment_time->appointment_duration,$start_time,$end_time);
        foreach($slots as $key=>$slot){
            $time['start'] = $slot['start'];
            $time['end'] = $slot['end'];
           
           $user_app = DB::table('appointments')->where('appointment_date',"'".$date."'")
           ->where(function($query) use ($time) {
                $query->where('appointment_time', '<=',$time['start'])
                ->Where('appointment_end_time','>',$time['start']);
           })->orWhere(function($query) use ($time) {
                $query->where('appointment_time', '<',$time['end'])
                ->Where('appointment_end_time', '>=',$time['end']);
           })
           ->first();

           $admin_app = DB::table('admin_appointments')
           ->where('appointment_date',"'".$date."'")
           ->where(function($query) use ($time) {
                $query->where('appointment_time', '<=',$time['start'])
                ->Where('appointment_end_time','>',$time['start']);
           })->orWhere(function($query) use ($time) {
                $query->where('appointment_time', '<', $time['end'])
                ->Where('appointment_end_time', '>=',$time['end']);
           })->first();

           if($user_app || $admin_app){
               echo $time['start']."--".$time['end'];
               //echo $time['end'];
              $slots[$key]['is_booked'] = true;
           }else{
            $slots[$key]['is_booked'] = false;
           }
           
        }
        return Helper::constructResponse(true,'Slots details',200,$slots);
    }


    public function getSlots($duration, $start,$end){
        $start = new DateTime($start);
        $end = new DateTime($end);
        $start_time = $start->format('H:i');
        $end_time = $end->format('H:i');
        $i=0;
        while(strtotime($start_time) <= strtotime($end_time)){
            $start = $start_time;
            $end = date('H:i',strtotime('+'.$duration.' minutes',strtotime($start_time)));
            
            $start_time = date('H:i',strtotime('+'.$duration.' minutes',strtotime($start_time)));
            
            if(strtotime($start_time) <= strtotime($end_time)){
                $time[$i]['start'] = $start;
                $time[$i]['end'] = $end;
            }
            $i++;
        }
        return $time;
    }


    public function get_next_question($consultId){
        return 4;
    }

    

}
