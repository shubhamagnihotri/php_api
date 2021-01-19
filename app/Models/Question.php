<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
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
    protected $table = 'ques';


    //Returns the next question details
    public function getFirstQuestion(){        
        $ques = Question::select("id","ques_title","ques_option_type","is_sub_question","condition_type","gender_id","from_age_condition","to_age_condition","pre_question_id","next_question_id","is_last_question")
                // ->whereNull('pre_question_id')    
                ->where('is_first_question',1)         
                ->first();        
        return $ques;
    }//eo getNextQuestion()

    public function getNextQuestionionId($question_id){
        $ques = Question::select("next_question_id")
                ->where('id',$question_id)->first();
        return $ques;
    }

    public function getQuestionDetails($question_id){        
        $ques = Question::select("id","ques_title","ques_option_type","is_sub_question","condition_type","gender_id","from_age_condition","to_age_condition","pre_question_id","next_question_id","is_last_question")
                ->where('id',$question_id)
                ->first();                    
        return $ques;
    }


    // This function return if question has the subquestion with the following option
    public function isChildQuestionOfOption($option_id){
        $is_sub_ques =  Question::select("id","ques_title","ques_option_type","is_sub_question","condition_type","gender_id","from_age_condition","to_age_condition","pre_question_id","next_question_id","is_last_question")
                ->where('ques_parent_option_id',$option_id)
                ->where('ques_status',1)                
                ->first();
        return $is_sub_ques;
    }//eo isChildQuestionOfOption()
}
