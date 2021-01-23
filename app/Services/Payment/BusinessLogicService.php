<?php

namespace App\Services\Payment;

use App\Models\Otp;
use App\Models\User;
use App\Models\UserRole;
use App\Models\UserSession;
use App\Models\AppointmentPrice;
use App\Helpers\CustomHelper as Helper;
use Carbon\Carbon;
use Hash;
use Mail;
use Illuminate\Support\Facades\Storage;
class BusinessLogicService
{
    public function __construct()
    {
    }

    public function getPricePlans($formdata,$id){
        $price = AppointmentPrice::select('id','appointment_type_name','appointment_price','appointment_duration','type')
        ->where('id',$id)
        ->first();
        return Helper::constructResponse(false,'',200,$price);
    }

    

 


}
