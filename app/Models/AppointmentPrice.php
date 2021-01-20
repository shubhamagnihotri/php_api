<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AppointmentPrice extends Model
{
    //
    protected $hidden = [];
    protected $primaryKey = 'id';
    protected $table = 'appointment_prices';

    public function getPriceDetails($price_id){
        $price = AppointmentPrice::select('id','appointment_type_name','appointment_price','appointment_duration','type')
            ->where('id',$price_id)
            ->first();
        return $price;
    }
}
