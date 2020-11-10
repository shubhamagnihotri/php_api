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

    public function updateProfileStatusvalidation($formData)
    {
        $validation['rules'] = [
            'status' => ['required'],
        ];
        $validation['messages'] = [
            'status.required' => 'Provide provide status',
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }

    public function addProductvalidation($formData)
    {
        $validation['rules'] = [
            'product_title' => ['required'],
            'product_url' => ['required'],
            'product_images' => ['required','array','min:1'],
            'product_images.*' => ['required','min:1'],
            'product_associated_concern' => ['required','array','min:1'],
            'product_associated_concern.*' => ['required','string','min:1'],
            'product_associated_condition' => ['required','array','min:1'],
            'product_associated_condition.*' => ['required','string','min:1'],
        ];
        $validation['messages'] = [
            'product_title.required' => 'plaese enter product title ',
            'product_url.required' => 'plaese enter product url ',
            'product_images.required' => 'plaese enter product images ',
            'product_images.array' => 'plaese enter product images ',
            'product_images.min' => 'plaese enter product images ',
            'product_associated_concern.required' => 'plaese enter product concern type ',
            'product_associated_concern.array' => 'plaese enter product concern type ',
            'product_associated_concern.min' => 'plaese enter product concern type ',
            'product_associated_condition.required' => 'plaese enter product condition type ',
            'product_associated_condition.array' => 'plaese enter product condition type',
            'product_associated_condition.min' => 'plaese enter product condition type',
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }

    public function updateProductStatusvalidation($formData)
    {
        $validation['rules'] = [
            'status' => ['required'],
        ];
        $validation['messages'] = [
            'status.required' => 'Provide provide status',
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }


    
    public function updateProductDetailvalidation($formData)
    {
        $validation['rules'] = [
            'product_title' => ['required'],
            'product_url' => ['required'],
            'product_images' => ['required','array','min:1'],
            'product_images.*' => ['required','min:1'],
            'product_associated_concern' => ['required','array','min:1'],
            'product_associated_concern.*' => ['required','string','min:1'],
            'product_associated_condition' => ['required','array','min:1'],
            'product_associated_condition.*' => ['required','string','min:1'],
        ];
        $validation['messages'] = [
            'product_title.required' => 'plaese enter product title ',
            'product_url.required' => 'plaese enter product url ',
            'product_images.required' => 'plaese enter product images ',
            'product_images.array' => 'plaese enter product images ',
            'product_images.min' => 'plaese enter product images ',
            'product_associated_concern.required' => 'plaese enter product concern type ',
            'product_associated_concern.array' => 'plaese enter product concern type ',
            'product_associated_concern.min' => 'plaese enter product concern type ',
            'product_associated_condition.required' => 'plaese enter product condition type ',
            'product_associated_condition.array' => 'plaese enter product condition type',
            'product_associated_condition.min' => 'plaese enter product condition type',
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }

        
    public function addAdminAppointmentValidation($formData)
    {
        $validation['rules'] = [
            'appointment_date' => ['required'],
            'appointment_time' => ['required'],
            'appointment_type' => ['required'],
            'appointment_duration' => ['required'],
            'appointment_title' => ['required']
        ];
        $validation['messages'] = [
            'appointment_title.required' => 'plaese enter title',
            'appointment_type.required' => 'plaese enter type',
            'appointment_date.required' => 'plaese enter date',
            'appointment_time.required' => 'plaese enter time',
            'appointment_duration.required' => 'plaese enter duration',
            
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;

    }

    public function getAppointmentDetail($formData)
    {
        $validation['rules'] = [
            'appointment_type' => ['required']
        ];
        $validation['messages'] = [
            'appointment_type.required' => 'plaese enter type',
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;

    }


    
    public function updateAppointmentStatusValidation($formData)
    {
        $validation['rules'] = [
            'appointment_type' => ['required'],
            'status' => ['required']
        ];
        $validation['messages'] = [
            'appointment_type.required' => 'plaese enter type',
            'status.required' => 'plaese enter status',
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;

    }

    public function updateAdminAppointmentsValidation($formData){
        $validation['rules'] = [
            'appointment_date' => ['required'],
            'appointment_time' => ['required'],
            'appointment_type' => ['required'],
            'appointment_by'=>['required']
        ];
        $validation['messages'] = [
            'appointment_date.required' => 'plaese enter date',
            'appointment_time.required' => 'plaese enter time',
            'appointment_type.required' => 'plaese enter type',
            'appointment_by.required' => 'plaese enter type',
        ];
       
        $validation = Validator::make($formData, $validation['rules'], $validation['messages']);
        if ($validation->fails()) {
            $apiResponse = $validation->errors();
            return Helper::constructResponse(true,'validation error',400,$apiResponse);
        }
      
        return false;
    }


}
