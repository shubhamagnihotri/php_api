<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Appointment extends Model
{
    //
    protected $hidden = [];
    protected $primaryKey = 'id';
    protected $table = 'appointments';

    public function markAppointmentAsPaymentDone($id){
        Appointment::where('id', $id)
        ->update(['payment_status' => 1]);
    }

    public function rescheduleAppointment($id,$update_data){
        return Appointment::where('id', $id)
        ->update($update_data);
    }
    public function cancelAppointment($id,$user_id){
        return Appointment::where('id', $id)
                ->where('user_id', $user_id)
                ->update(['appointment_status' => 2]); //cancel
    }


}
