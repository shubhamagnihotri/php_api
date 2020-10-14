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

     /**
     * validate registration
     * @return json
    */
    public function validateupdateProfile($formData)
    {
        $validation['rules'] = [
            'fname' => ['required'],
            'lname' => ['required'],
            // 'email' => ['required','email'],
            'ethinicity' => ['required'],
            'gender' => ['required'],
            'mobile_number' => ['required'],
            'address' => ['required'],
            'state' => ['required'],
            'country' => ['required'],
            'zip_code' => ['required'],
            'date_of_birth' => ['required','date_format:d-m-Y'],
        ];
        $validation['messages'] = [
            'fname.required' => 'First Name is required',
            'lname.required' => 'Last Name is required',
            'email.required' => 'Email is required',
            'email.email' => 'Email should be email address',
            'ethinicity.required' => 'Ethinicity is required',
            'gender.required' => 'Gender is required',
            'mobile_number.required' => 'Mobile Number is required',
            'address.required' => 'Address is required',
            'state.required' => 'Address is required',
            'country.required' => 'Country is required',
            'zip_code.required' => 'Zip Code is required',
            'date_of_birth.required' => 'Date of birth is required',
            'date_of_birth.date_format' => 'Date of birth format should be d-m-Y',
        ];
        
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
          
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        return false;
    }

    /**
     * validate login
     * @return json
    */
    public function validateLogin($formData)
    {
        $validation['rules'] = [
            'email' => ['required','email'],
            'password' => ['required','min:8'],
        ];
        $validation['messages'] = [
            'email.required' => 'Email is required',
            'email.email' => 'Email should be valid email address',
            'password.required'=>'Password is required'
        ];
        
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        return false;
    }


    /**
     * validate login
     * @return json
    */
    public function validatePassword($formData)
    {
        $validation['rules'] = [
            'email' => ['required','email'],
            'password' => ['required','min:8'],
            'confirm_password' => ['required','same:password'],
            'temp_token' => ['required'],
        ];
        $validation['messages'] = [
            'email.required' => 'Email is required',
            'email.email' => 'Email should be valid email address',
            'password.required'=>'Password is required',
            'password.min'=>'Password Should me minimum 8 character',
            'confirm_password.min'=>'Confirm Password is required',
            'confirm_password.same'=>'Confirm Password should be same as password',
            'temp_token.required'=>'Can not proceed',
        ];
        
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        return false;
    }

    
    /**
     * validate login
     * @return json
    */
    public function validateSocialMediaSignUp($formData)
    {
        $validation['rules'] = [
            'fname' => ['required'],
            'email'=>['required','email'],
            'social_media_type' => ['required'],
            'social_media_id' => ['required'],
        ];
        $validation['messages'] = [
            'fname.required' => 'First name is required',
            'email.required' => 'Email is required',
            'email.email' => 'Email should be valid email address',
            'social_media_type.required'=>'Social media known platfrom required',
            'social_media_id.required'=>'Social media known platfrom required',
        ];
        
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
        return false;
    }



}
