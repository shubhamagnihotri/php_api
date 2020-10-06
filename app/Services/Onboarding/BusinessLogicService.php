<?php

namespace App\Services\Onboarding;

use App\Models\Otp;
use App\Models\User;
use App\Models\UserRole;
use App\Models\UserSession;
use App\Helpers\CustomHelper as Helper;
use Carbon\Carbon;
use Hash;


class BusinessLogicService
{
    public function __construct()
    {
    }

    public function generateOtp($formData)
    {
        $isUserSignedUp=User::where('email',$formData['email'])->first();
        if($isUserSignedUp){
            return Helper::constructResponse(true,'Sign up already done',401,[]);
        }
        $bytes = random_bytes(50);
        $temp_token= bin2hex($bytes);
        $otpGenearted = Otp::insert([
            'email'=>$formData['email'],
            'email_otp'=>mt_rand(100000,999999),
            'temp_token'=>$temp_token,
            'status'=>1,
            'created_at'=>Carbon::now()
        ]);
        if($otpGenearted ){
            return Helper::constructResponse(false,'Otp generated successfully !',200,[]);
        }else{
            return Helper::constructResponse(true,'Otp not generated !',401,[]);
        }
    }



    public function validateOtp($formData)
    {
        $otpDetail = Otp::where('email',$formData['email'])->orderBy('id','desc')->first();
        if($otpDetail && $otpDetail['email_otp'] == $formData['otp']){
           $create_strtotime = strtotime($otpDetail->created_at);
           $allowed_strtotime =  $create_strtotime+(60*5);
           $incomming_req_strtotime = strtotime(date("Y-m-d H:i:s"));
           if($incomming_req_strtotime > $allowed_strtotime){
            return Helper::constructResponse(false,'Otp time expires!',401,[]);
           }
            $otpDetail->status = 0;
            $otpDetail->save();
            $result['temp_token'] = $otpDetail->temp_token;
            return Helper::constructResponse(false,'Otp matched successfully !',200,$result);
        }else{
            return Helper::constructResponse(true,'Otp not matched successfully!',401,[]);
        }
    }


    // generatePassword
    public function generatePassword($formData)
    {
       
        $isUserSignedUp=User::where('email',$formData['email'])->first();
        if($isUserSignedUp){
            return Helper::constructResponse(true,'Sign up already done',401,[]);
        }
        $userOtpDetail=Otp::where('email',$formData['email'])->orderBy('id','desc')->first();
        if(!$userOtpDetail || $userOtpDetail['temp_token'] != $formData['temp_token']){
            return Helper::constructResponse(true,'Wrong detail',401,[]);
        }
        $usermodel = new User();
        $usermodel->email = $formData['email'];
        $usermodel->password = bcrypt($formData['password']);
        $usermodel->save();
        if($usermodel){
            UserRole::insert([
                'user_id'=>$usermodel->id,
                'role_id'=>2
            ]);
            return Helper::constructResponse(false,'Password set successfully',200,$usermodel);
        }else{
            return Helper::constructResponse(true,'Sign up not successfully',401,[]);
        }
        
    }

    public function socialMediaSignUp($formData)
    {
        $isUserSignedUp=User::where('email',$formData['email'])->orWhere('social_media_id',$formData['social_media_id'])->first();
        if($isUserSignedUp){
            return Helper::constructResponse(true,'Signup already done',401,[]);
        }
        $usermodel = new User();
        $usermodel->email = $formData['email'];
        $usermodel->fname = $formData['fname'];
        $usermodel->lname = $formData['lname'];
        $usermodel->signup_type = $formData['social_media_type'];
        $usermodel->password = bcrypt($formData['social_media_id']);
        $usermodel->social_media_id = $formData['social_media_id'];
        $usermodel->save();
        if($usermodel){
            UserRole::insert([
                'user_id'=>$usermodel->id,
                'role_id'=>2
            ]);
            return Helper::constructResponse(false,'',200,$usermodel);
        }else{
            return Helper::constructResponse(true,'Sign up not done successfully',401,[]);
        }
    }

    // update session model
    public function updateSessionModel($token,$userId)
    {
        UserSession::insert([
            'user_id'=>$userId,
            'token'=>$token
        ]);
        return true;  
    }
    
    // get role by user id
    public function getuserById($userId)
    {
        $user = User::where('id',$userId)->first();
        return $user;  
    }


    // get role by user id
    public function getRoleByuserId($userId)
    {
        $role = UserRole::select('user_roles.role_id','roles.role_name')->
        join('roles','user_roles.role_id','roles.id')->where('user_id',$userId)->get();
        return $role;  
    }



    // do registration
    public function updateProfile($formData,$userDetail)
    {
        $updatedData = [
            'fname'=>$formData['fname'],
            'lname'=>$formData['lname'],
            // 'email'=>$formData['email'],
            'ethinicity'=>$formData['ethinicity'],
            'gender'=>$formData['gender'],
            'mobile_number'=>$formData['mobile_number'],
            'address'=>$formData['address'],
            'state'=>$formData['state'],
            'country'=>$formData['country'],
            'zip_code'=>$formData['zip_code'],
            'profile_status'=>1
        ];
        $userSignUp=User::where('id',$userDetail->id)->update($updatedData);
        if($userSignUp){
            return Helper::constructResponse(false,'Profile updated successfully',200,null);
        }else{
            return Helper::constructResponse(true,'Profile updated not successfully',401,[]);
        }
        
    }

    public function login($formData)
    {
        $isUserSignedUp=User::where('email',$formData['email'])->first();
        if(!$isUserSignedUp){
            return Helper::constructResponse(true,'User not exist',401,[]);
        }
        if(Hash::check($formData['password'],$isUserSignedUp->password)){
            $result['token'] = 'sssss';
            return Helper::constructResponse(false,'Password matched successfully',401,$result);
        }else{
            return Helper::constructResponse(true,'Password not matched',401,[]);
        }
    }


    // logout by token (delete token from model) 
    public function logout($token)
    {
       $isDeleted =  UserSession::where('token',$token)->delete();
        return true;  
    }

 


}
