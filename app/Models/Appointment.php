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
}
