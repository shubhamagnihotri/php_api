<?php

namespace App\Services\User;
use Validator;
use App\Helpers\CustomHelper as Helper;
class ValidationService
{
    public function __construct()
    {

    }

    /**
     * validate customer with token and providing
     * customer detail and databackupdetail
     * @param [request] $token
     * @return json
    */
    public function test($formData)
    {
        $validation['rules'] = [
            'generation' => ['required'],
            'password' => ['required', 'min:8', 'max:32'],
            'confirmPassword' => ['required', 'min:8', 'max:32', 'same:password'],
        ];
        $validation['messages'] = [
            'generation.required' => 'databackup.generation.required',
            'password.required' => 'databackup.password.required',
            'password.min' => 'databackup.password.minlength',
            'password.max' => 'databackup.password.maxlength',
            'confirmPassword.required' => 'databackup.confirmPassword.required',
            'confirmPassword.min' => 'databackup.confirmPassword.minlength',
            'confirmPassword.max' => 'databackup.confirmPassword.maxlength',
            'confirmPassword.same' => 'databackup.confirmPassword.same',
            'created_by.unique' => 'databackup.created_by.exist',
        ];
        
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400, [$apiResponse]);
        }
        return false;
    }


}
