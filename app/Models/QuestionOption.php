<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class QuestionOption extends Model
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
    protected $table = 'ques_options';

    public function getOptionOfQuestion($question_id){
        return QuestionOption::select("id","option_title","option_ques_id","static_page_id","option_image")
            ->where('option_ques_id',$question_id)
            ->where('option_status',1)
            ->get();
    }

    public function getOptionDetails($id){
        return QuestionOption::select("id","option_title","option_ques_id","static_page_id","option_image")
            ->where('id',$id)            
            ->first();
    }
}
