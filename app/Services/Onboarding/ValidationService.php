<?php

namespace App\Services\Onboarding;
use Validator;
use App\Helpers\CustomHelper as Helper;
class ValidationService
{
    public function __construct()
    {

    }

    /**
     * validate email
     * @return json
    */
    public function validateGenerateOtp($formData)
    {
        $validation['rules'] = [
            'email' => ['required'],
        ];
        $validation['messages'] = [
            'email.required' => 'Email is required',
        ];
        
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        return false;
    }

     /**
     * validate email otp
     * @return json
    */
    public function validateEmailOtp($formData)
    {
        $validation['rules'] = [
            'email' => ['required','email'],
            'otp' => ['required','min:6','max:6'],
        ];
        $validation['messages'] = [
            'email.required' => 'Email is required',
            'email.email' => 'Email should be valid email address',
            'otp.required' => 'Otp is required',
            'otp.min' => 'Otp should be minimun 6 digit',
            'otp.max' => 'Otp should be maximum 6 digit',
        ];
        
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        return false;
    }


}
