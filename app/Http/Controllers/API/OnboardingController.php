<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helpers\CustomHelper as Helper;
use App\Services\Onboarding\BusinessLogicService;
use App\Services\Onboarding\ValidationService;
class OnboardingController extends Controller
{
    public function __construct()
    {
        $this->validationServiceObject = new ValidationService();
        $this->businessLogicServiceObject = new BusinessLogicService();
        //parent::__construct();
    }

    // gnerate email otp 
    public function generateOtp(Request $request){
        $isValidationFailed=$this->validationServiceObject->validateGenerateOtp($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
       $response = $this->businessLogicServiceObject->generateOtp($request->all());
       return response()->json($response);
    }

     // validate email otp 
    public function validateOtp(Request $request){
        $isValidationFailed=$this->validationServiceObject->validateEmailOtp($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
       $response = $this->businessLogicServiceObject->validateOtp($request->all());
       return response()->json($response);
    }

    
}
