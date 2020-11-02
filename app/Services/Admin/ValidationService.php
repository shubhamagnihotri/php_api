<?php
namespace App\Services\Admin;
use App\Helpers\CustomHelper as Helper;
use Validator;
class ValidationService
{
    public function __construct()
    {

    }

     /**
     * validate email
     * @return json
    */
    public function getConsultationQueueValidate($formData)
    {
        $validation['rules'] = [
            'consultantion_status' => ['required'],
        ];
        $validation['messages'] = [
            'consultantion_status.required' => 'Provide all required params'
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }


    
    public function generateCarVadiation($formData)
    {
        $validation['rules'] = [
            'car_report_response' => ['required'],
        ];
        $validation['messages'] = [
            'car_report_response.required' => 'Provide provide car details'
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }

   
    public function addConsultationNotesvalidation($formData)
    {
        $validation['rules'] = [
            'note_type' => ['required'],
            'condition_id' => ['required'],
            'consultation_note' => ['required'],
        ];
        $validation['messages'] = [
            'note_type.required' => 'Provide provide note type',
            'condition_id.required' => 'Provide provide condition type',
            'consultation_note.required' => 'Provide enter Note'
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }

}
