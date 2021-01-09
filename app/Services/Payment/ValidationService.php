<?php

namespace App\Services\Payment;
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
            'email' => ['required','email'],
        ];
        $validation['messages'] = [
            'email.required' => 'Email is required',
            'email.email' => 'Email should be valid email address',
        ];
        
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }
}
