<?php

namespace App\Services\Onboarding;

use App\Models\Otp;
// use App\Traits\DaemonApiTrait;
use App\Helpers\CustomHelper as Helper;

class BusinessLogicService
{
    public function __construct()
    {

    }

    public function generateOtp($formData)
    {
        $bytes = random_bytes(50);
        $temp_token= bin2hex($bytes);
        $otpGenearted = Otp::insert([
            'email'=>$formData['email'],
            'email_otp'=>mt_rand(100000,999999),
            'temp_token'=>$temp_token,
            'status'=>1
        ]);
        if($otpGenearted ){
            return Helper::constructResponse(false,'Otp generated successfully !',401,[]);
        }else{
            return Helper::constructResponse(true,'Otp not generated !',401,[]);
        }
    }

    public function validateOtp($formData)
    {
        $otpDetail = Otp::where('email',$formData['email'])->orderBy('id','desc')->first();
        if($otpDetail && $otpDetail['email_otp'] == $formData['otp']){
            $otpDetail->status = 0;
            $otpDetail->save();
            $result['temp_token'] = $otpDetail->temp_token;
            return Helper::constructResponse(false,'Otp matched successfully !',200,$result);
        }else{
            return Helper::constructResponse(true,'Otp not matched successfully!',401,[]);
        }
    }


}
