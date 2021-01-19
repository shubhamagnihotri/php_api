<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Consultant extends Model
{
         /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [];
    protected $primaryKey = 'id';
    protected $table = 'consultations';


    public function markConsultationAsImageSubmitted($consultation_id){
        Consultant::where('id', $consultation_id)
        ->update(['consultant_status' => 4]); //ques and images submit payment not done
    }

    public function markConsultationAsDisabled($consultation_id){
        Consultant::where('id', $consultation_id)
        ->update(['consultant_status' => 6]);//Disabled
    }

    public function markConsultationAsQuestionCompleted($consultation_id){
        Consultant::where('id', $consultation_id)
        ->update(['consultant_status' => 5]);//question done and images pending
    }
}
