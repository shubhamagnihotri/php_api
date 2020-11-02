<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class QuesOptionNextQuestion extends Model
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
    protected $table = 'ques_options_next_questions';
}
