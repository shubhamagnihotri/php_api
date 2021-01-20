<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PaymentDetails extends Model
{
         /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        "id","consultation_id","appointment_id","user_id","amount","transaction_id",
        "balance_transaction","status","response","created_at","updated_at","card_num",
        "card_brand","payment_type"
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [];
    protected $primaryKey = 'id';
    protected $table = 'payment_details';

    public function save_data($data){               
                $this->create($data);
                return $this->id;
    }
}
