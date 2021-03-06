<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helpers\CustomHelper as Helper;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Question;
use App\Models\QuestionOption;
use App\Models\QuesCondition;
use App\Models\Consultant;
use App\Models\QuesAnswerConsultant;
use App\Models\Files;
use App\Models\Appointment;
use App\Models\PrmotionVideos;
use Validator;
use App\Services\Admin\BusinessLogicService;
use App\Services\Admin\ValidationService;
class AdminController extends Controller
{
    public function __construct()
    {
        $this->validationServiceObject = new ValidationService();
        $this->businessLogicServiceObject = new BusinessLogicService();
       
    }

    public function getConsultationQueue(Request $request){
        $isValidationFailed=$this->validationServiceObject->getConsultationQueueValidate($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->getConsultationQueue($request->all());
        return response()->json($response);
    }

    public function getConsultationFullDetail(Request $request,$id){
        $response = $this->businessLogicServiceObject->getConsultationFullDetail($id);
        return response()->json($response);
    }

    public function generateCar(Request $request,$id){
        $isValidationFailed=$this->validationServiceObject->generateCarVadiation($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->generateCar($request->all(),$id);
        return response()->json($response);
    }

    public function addConsultationNotes(Request $request,$id){
        $isValidationFailed=$this->validationServiceObject->addConsultationNotesvalidation($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $user_id=$request->user->id;
        $response = $this->businessLogicServiceObject->addConsultationNotes($request->all(),$id,$user_id);
        return response()->json($response);

    }

    public function getGeneratedCarDetail(Request $request,$id){
        $user_detail=$request->user;
        $response = $this->businessLogicServiceObject->getGeneratedCarDetail($user_detail,$id);
        return response()->json($response);
    }

    public function getUsersData(Request $request){
        $response = $this->businessLogicServiceObject->getUsersData($request->all());
        return response()->json($response);
    }

    public function getUserDetail(Request $request,$id){
        $response = $this->businessLogicServiceObject->getUserDetail($request->all(),$id);
        return response()->json($response);
    }

    public function updateProfileStatus(Request $request,$id){
     
        $isValidationFailed=$this->validationServiceObject->updateProfileStatusvalidation($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->updateProfileStatus($request->all(),$id);
        return response()->json($response);
    }

    public function getConcernAndConditionType(Request $request){
        $response = $this->businessLogicServiceObject->getConcernAndConditionType($request->all());
        return response()->json($response);
    }

    
    public function addProduct(Request $request){
        // $isValidationFailed=$this->validationServiceObject->addProductvalidation($request->all());
        // if ($isValidationFailed) {
        //     return response()->json($isValidationFailed, 400);
        // }
        $response = $this->businessLogicServiceObject->addProduct($request->all());
        return response()->json($response);
    }

    public function getProductByConcern(Request $request,$id){
        $response = $this->businessLogicServiceObject->getProductByConcern($request->all(),$id);
        return response()->json($response);
    }

    public function updateProductStatus(Request $request,$id){
        $isValidationFailed=$this->validationServiceObject->updateProductStatusvalidation($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->updateProductStatus($request->all(),$id);
        return response()->json($response);
    }

    public function getProductDetail(Request $request,$id){
        $response = $this->businessLogicServiceObject->getProductDetail($request->all(),$id);
        return response()->json($response);
    }

    
    public function updateProductDetail(Request $request,$id){
        $response = $this->businessLogicServiceObject->updateProductDetail($request->all(),$id);
        return response()->json($response);
    }

    public function deleteProductImage(Request $request,$id){
      
        $response = $this->businessLogicServiceObject->deleteProductImage($id);
        return response()->json($response);
    }

    public function getProductRelatedConsulation(Request $request,$id){
        $response = $this->businessLogicServiceObject->getProductRelatedConsulation($request->all(),$id);
        return response()->json($response);
    }

    public function deleteProductById(Request $request,$id){
        $response = $this->businessLogicServiceObject->deleteProductById($request->all(),$id);
        return response()->json($response);
    }

    
    public function addAdminAppointment(Request $request){
        $isValidationFailed=$this->validationServiceObject->addAdminAppointmentValidation($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->addAdminAppointment($request->all());
        return response()->json($response);
    }

    public function getAppointmentDetail(Request $request,$id){
        $isValidationFailed=$this->validationServiceObject->getAppointmentDetail($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->getAppointmentDetail($request->all(),$id);
        return response()->json($response);
    }

    public function updateAppointmentStatus(Request $request,$id){
        $isValidationFailed=$this->validationServiceObject->updateAppointmentStatusValidation($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->updateAppointmentStatus($request->all(),$id);
        return response()->json($response);
    }

    public function updateAdminAppointment(Request $request,$id){
        $isValidationFailed=$this->validationServiceObject->updateAdminAppointmentsValidation($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->updateAdminAppointment($request->all(),$id);
        return response()->json($response);
    }

    public function getAppointments(Request $request){
        $response = $this->businessLogicServiceObject->getAppointments($request->all());
        return response()->json($response);
    }

    public function addQuestion(Request $request){
       
        $response = $this->businessLogicServiceObject->addQuestion($request->all());
        return response()->json($response);
    }

    public function getQuestionDetail(Request $request,$id){
       
        $response = $this->businessLogicServiceObject->getQuestionDetail($request->all(),$id);
        return response()->json($response);
    }

    public function deleteQuesOption(Request $request,$id){
       
        $response = $this->businessLogicServiceObject->deleteQuesOption($request->all(),$id);
        return response()->json($response);
    }
    public function editQuestion(Request $request,$id){
       
        $response = $this->businessLogicServiceObject->editQuestion($request->all(),$id);
        return response()->json($response);
    }

    public function updateVideo(Request $request){
        // $isValidationFailed=$this->validationServiceObject->updateVideoValidation($request->all());
        // if ($isValidationFailed) {
        //     return response()->json($isValidationFailed, 400);
        // }
        $response = $this->businessLogicServiceObject->updateVideo($request->all());
        return response()->json($response);
    }

    public function getPromVideo(Request $request){
        $response = $this->businessLogicServiceObject->getPromVideo($request->all());
        return response()->json($response);
    }

    public function getStaticPagesDetails(Request $request){
        $response = $this->businessLogicServiceObject->getStaticPagesDetails($request->all());
        return response()->json($response);
    }

    
    public function getStaticPageDetails(Request $request,$id){
        $response = $this->businessLogicServiceObject->getStaticPageDetails($request->all(),$id);
        return response()->json($response);
    }
    
    public function addStaticPages(Request $request){
      
        $response = $this->businessLogicServiceObject->addStaticPages($request->all());
        return response()->json($response);
    }

    public function deleteStaticPage(Request $request,$id){
      
        $response = $this->businessLogicServiceObject->deleteStaticPage($id);
        return response()->json($response);
    }
    public function getRootLevelQuestion(Request $request){
      
        $response = $this->businessLogicServiceObject->getRootLevelQuestion($request->all());
        return response()->json($response);
    }

    public function updateQuestionLinking(Request $request){
      
        $response = $this->businessLogicServiceObject->updateQuestionLinking($request->all());
        return response()->json($response);
    }

    
    public function getQuesLinkingQuestions(Request $request){
        $response = $this->businessLogicServiceObject->getQuesLinkingQuestions($request->all());
        return response()->json($response);
    }

    public function deleteQuestion(Request $request,$id){
        $response = $this->businessLogicServiceObject->deleteQuestion($id);
        return response()->json($response);
    }

    public function getConsultationCount(Request $request){
        // $isValidationFailed=$this->validationServiceObject->consultationCount($request->all());
        // if ($isValidationFailed) {
        //     return response()->json($isValidationFailed, 400);
        // }
        $response = $this->businessLogicServiceObject->consultationCount($request->all());
        return response()->json($response);
    }

    public function recommendedProducts(Request $request){
        $response = $this->businessLogicServiceObject->recommendedProducts($request->all());
        return response()->json($response);
    }


    public function uploadImage(Request $request){
        $response = $this->businessLogicServiceObject->uploadImage($request->all());
        return response()->json($response);
    }

    public function getQuestionForStaticPage(){
        $response = $this->businessLogicServiceObject->getQuestionForStaticPage();
        return response()->json($response);
    }

    public function getOptionOfQuestion($question_id){
        $response = $this->businessLogicServiceObject->getOptionOfQuestion($question_id);
        return response()->json($response);
    }

    public function getConfigurableNextQuestion($question_id){
        $questionObj =new Question();
        $questionOptionObj = new QuestionOption();
        $question = $questionObj->getQuestionDetails($question_id);
        if($question)
        {
            $options = $questionOptionObj->getOptionOfQuestion($question->id);
            $question['options'] = $options; 
            if($question->ques_option_type == 1){
                    foreach($options as $option){
                        
                        $subQuestion = $this->getConfigurableSubQUestions($option->id);
                        if($subQuestion){
                            $option['question'] = $subQuestion;
                        }
                    }
                }
        }
        
        // if($question->ques_option_type == 1){
        //     foreach($options as $option){
                
        //         $subQuestion = $this->getConfigurableSubQUestions($option->id);
        //         if($subQuestion){
        //             $option['question'] = $subQuestion;
        //         }
        //     }
        // }
        
        
        // if(!$question->is_last_question){
        //     if($question->next_question_id){
        //         return $this->getConfigurableNextQuestion($question->next_question_id);
        //     }
        // }
        return $question;
        
        

        return $questions;
    }

    public function getConfigurableSubQUestions($option_id)
    {
        // echo $option_id;
        $questionObj =new Question();
        $questionOptionObj = new QuestionOption();
        $question =  $questionObj->isChildQuestionOfOption($option_id);
        if($question)
        {
            $options = $questionOptionObj->getOptionOfQuestion($question->id);
            $question['options'] = $options; 
            if($question->ques_option_type == 1){
                    foreach($options as $option){
                        
                        $subQuestion = $this->getConfigurableSubQUestions($option->id);
                        if($subQuestion){
                            $questions = array();
                            $questions[] = $subQuestion;
                            
                            $next_question_id = $subQuestion->next_question_id;                            
                            do{

                                $q = $this->getConfigurableNextQuestion($next_question_id);
                                
                                $next_question_id = 0;
                                if($q){
                                    if($q->ques_level != 1)
                                    {
                                        $questions[] = $q;
                                        if(!$q->is_last_question ){
                                            if($q->next_question_id){
                                                $next_question_id = $q->next_question_id;
                                            }
                                        }
                                    }
                                    
                                }
                                
                            }while($next_question_id);
                            $option['questions'] = $questions;
                           
                        }
                    }
                }
        }
        return $question;
    }

    public function getConfigurableQuestions(){
        $questionObj =new Question();
        $questionOptionObj = new QuestionOption();
        $firstQuestion = $questionObj->getFirstQuestion();
        $options = $questionOptionObj->getOptionOfQuestion($firstQuestion->id);
        $next_question_id = $firstQuestion->next_question_id;
        if($firstQuestion->ques_option_type == 1){
            foreach($options as $option){                
                $subQuestion = $this->getConfigurableSubQUestions($option->id);
                if($subQuestion){
                    $option['question'] = $subQuestion;
                }
            }
        }
        $firstQuestion['options'] = $options; 
        $questions = array();
        $questions[] = $firstQuestion;
        do{

            $q = $this->getConfigurableNextQuestion($next_question_id);
            $questions[] = $q;
            $next_question_id = 0;
            if($q){
                if(!$q->is_last_question){
                    if($q->next_question_id){
                        $next_question_id = $q->next_question_id;
                    }
                }
            }
            
        }while($next_question_id);

        // $questions[] = $this->getConfigurableNextQuestion($next_question_id);

        return Helper::constructResponse(false,'',200,$questions);
    }


    // this function delete the video accroding to id
    public function deletePromotionVideo($video_id){
        $prmotionVideosObj = new PrmotionVideos();
        $status =  $prmotionVideosObj->deletePromotionVideo($video_id);
        if($status){
            return Helper::constructResponse(false,trans('message.video.success_delete'),200,[]);
        }else{
            return Helper::constructResponse(true,trans('message.video.fail_delete'),401,[]);
        }
    }//eo deletePromotionVideo()





}
