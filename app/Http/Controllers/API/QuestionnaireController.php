<?php

namespace App\Http\Controllers\API;

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
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Validator;
class QuestionnaireController extends Controller
{
    //

    public function getQuestionAndSubmitAnswer(Request $request){
        if ($request->isMethod('get')) {
            $response=$this->getFirstQuestion($request);
            return response()->json($response);
        }
        if ($request->isMethod('post')) {
            // getting next question 
            if($request->input('ques_step') == 'next'){
                $response= $this->submitQuestionAnswerGetQues($request->all(),$request->user);
            }
           
            return response()->json($response);
        }
    }

    // get first question and option start
    public function getFirstQuestion($formdata){
        $ques = Question::where('id',1)->where('ques_status',1)->first();
        if(!$ques){
            return Helper::constructResponse(true,'No Question are available',401,[]);
        }
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
    // get first question and option end


    // submit question answer and get next question (Next question )start
    public function submitQuestionAnswerGetQues($formdata,$userData){
        if(empty($formdata['consultation_id'])){
        // 
            $all_ques_array = array_column($formdata['submit_data'],'ques_id');
           
           if(!in_array(1,$all_ques_array)){
            return Helper::constructResponse(true,'please provide all params',400,[]);
           }
           $consultation_data = new Consultant();
           $consultation_data->user_id = $userData->id;
           $consultation_data->consultant_created_at = date("Y-m-d H:i:s");
           $consultation_data->consultant_status = 0;
           $consultation_data->created_at = date("Y-m-d H:i:s");
           $consultation_data->save();
          $formdata['consultation_id'] = $consultation_data->id;
        }
        $all_ques_array = array_column($formdata['submit_data'],'ques_id');
        $max_ques_id = max($all_ques_array);
        $max_ques_options = null;
        foreach($formdata['submit_data'] as $form){
            $ques_detail = Question::where('id',$form['ques_id'])->first();
        
            $consultOption =QuesAnswerConsultant::where('ques_id',$form['ques_id'])->where('consultant_id',$formdata['consultation_id'])->get();
            QuesAnswerConsultant::where('ques_id',$form['ques_id'])->where('consultant_id',$formdata['consultation_id'])->delete();
            if($form['ques_id'] == $max_ques_id){
                $max_ques_options = count($form['ques_answer']) == 1? $form['ques_answer'][0]:$form['ques_answer'][0];
            }
            foreach($form['ques_answer'] as $answer){
                $get_option_detail= QuestionOption::where('id',$answer)->first();
                $QuesAnswerConsult = new QuesAnswerConsultant();
                $QuesAnswerConsult->ques_id = $form['ques_id'];
                $QuesAnswerConsult->option_id = $answer; 
                if($ques_detail->ques_title){
                    $QuesAnswerConsult->question_for_admin= $ques_detail->ques_title;
                }
                if($get_option_detail->option_title){
                    $QuesAnswerConsult->answer_for_admin= $get_option_detail->option_title;
                }
                $QuesAnswerConsult->consultant_id = $formdata['consultation_id']; 
                $QuesAnswerConsult->save();
            }
        }

        if($formdata['is_last_question'] == 'true'){
            $consult_status=Consultant::where('id',$formdata['consultation_id'])->where('user_id',$userData->id)->update([
                'consultant_status'=>1,
                'consultant_ended_at'=>date("Y-m-d H:i:s")
            ]);
            $res = ['ques'=>[],'option'=> [],'is_final_ques_submitted'=>false];
            if($consult_status){
                $res['is_final_ques_submitted'] = true;
            }
            return Helper::constructResponse(false,'Option not available',401,$res);
        }
        if($max_ques_options != null){
            $option = QuestionOption::where('id',$max_ques_options)->where('option_status',1)->first();
            if(!$option){
                return Helper::constructResponse(true,'Option not available',401,[]);
            }
            if($option->option_check_condition_id != '0'){
                $checkingConditionsId = explode(",",$option->option_check_condition_id);
                $checkingConditions= QuesCondition::whereIn('id', $checkingConditionsId)->get();
                $includedGender =[];
                 
                foreach($checkingConditions as $conditions){
                    if($conditions['condition_title'] != 'Age'){
                        $includedGender[] = $conditions['condition_code'];
                    }else{
                        $checkAge = $conditions['condition_code'];
                    }
                }
                if(count($includedGender) > 0 && isset($checkAge)){
                    // dd('dd 1');
                    $age = date_diff(date_create($request->user->date_of_birth), date_create('today'))->y;
                    if(in_array($request->user->gender,$includedGender) && $age > $checkAge){
                        $next_ques_id = $option->option_condition_true_next_question_id;
                    }else{
                        $next_ques_id = $option->option_condition_false_next_question_id;
                    }
               
                }else if(count($includedGender) > 0 && !isset($checkAge)){
                   
                    if(in_array($request->user->gender,$includedGender)) {
                        $next_ques_id = $option->option_condition_true_next_question_id;
                    }else{
                        $next_ques_id = $option->option_condition_false_next_question_id;
                    }
                  
                }else if(count($includedGender) == 0 && isset($checkAge)){
                    // dd('dd 3');
                    $age = date_diff(date_create($request->user->date_of_birth), date_create('today'))->y;
                    if($age > $checkAge){
                        $next_ques_id = $option->option_condition_true_next_question_id;
                    }else{
                        $next_ques_id = $option->option_condition_false_next_question_id;
                    }
                }
                $ques = Question::where('id',$next_ques_id )->where('ques_status',1)->first();
                if(!$ques){
                    return Helper::constructResponse(true,'No Question are available',401,[]);
                }
                $option= QuestionOption::where('option_ques_id',$ques->id)->where('option_status',1)->get();
                return Helper::constructResponse(false,'',200,['ques'=>$ques,'option'=> $option]);

            }// option_check_condition_id == 0

            // when no conditions
            if($option->option_check_condition_id == 0){
                $ques = Question::where('ques_parent_option_id',$max_ques_options)->where('ques_status',1)->first();
               if(!$ques){
                $max_ques_id = $max_ques_id+1;
                $ques = Question::where('id',$max_ques_id)->where('ques_status',1)->first();
               }
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

        }// max ques option != null
      
    }
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
        $consultations=Consultant::where('user_id',$user_id)->orderBy('id','desc')->get();
       foreach($consultations as $consult){
            $files= Files::where('user_id',$user_id)->where('consultation_id',$consult['id'])->get();
            $consult['files']=  $files;
       }
       return Helper::constructResponse(false,'',200,['consultation_detail'=>$consultations]);
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
            $consultations['car_report_response']='ssss';
            $consultations['products']=[];
            $consultations['is_initial_meeting_done']=false;
            $consultations['is_followup_meeting_done']=false;
            $consultations['is_new_existing_meeting_done']=false;
            $initial_appointment = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('user_id',$user_id)->where('consultation_id',$id)
            ->where('appointment_type',1)->first();
            $followup_appointment = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('user_id',$user_id)->where('consultation_id',$id)
            ->where('appointment_type',2)->first();
            $new_on_existing = Appointment::join('appointment_prices','appointment_prices.id','appointments.appointment_type')->where('user_id',$user_id)->where('consultation_id',$id)
            ->where('appointment_type',3)->first();
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

    public function getConsultationSlots(Request $request){
        $date = $request->input('appointment_date');
        $type = $request->input('appointment_type');
        $appointment_time = AppointmentPrice::where('id',$type)->first();
        if(!$appointment_time){
            return Helper::constructResponse(true,'Something went wrong',200,[]);
        }
        $user_appointments =DB::table('appointments')->select('appointments.id','appointment_time','appointment_duration','appointment_status','appointments.appointment_type')->join('appointment_prices','appointment_prices.id','appointments.appointment_type')
        ->where('appointments.appointment_date',$date)->get();
    //    dd( $user_appointments);
        $admin_appointments= DB::table('admin_appointments')->select('admin_appointments.id','appointment_time','appointment_prices.appointment_duration','appointment_status','admin_appointments.appointment_type')->join('appointment_prices','appointment_prices.id','admin_appointments.appointment_type')
        ->where('admin_appointments.appointment_date',$date)->get();
      
        if(count($admin_appointments)){
            foreach($admin_appointments as $ap){
                $user_appointments[]=$ap;
            }
        }
    }

    

}