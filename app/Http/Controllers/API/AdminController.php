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
        $response = $this->businessLogicServiceObject->addConsultationNotes($request->all(),$id);
        return response()->json($response);

    }

    public function getGeneratedCarDetail(Request $request){

    }
}
