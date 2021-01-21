<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Files extends Model
{
    //
    protected $hidden = [];
    protected $primaryKey = 'id';
    protected $table = 'files';


    public function getUserConsultationImages($user_id,$consultation_id){
        $ques = Files::select("id","user_id","consultation_id","file_url","file_type","file_view_from")
                ->where('consultation_id',$consultation_id)        
                ->where('user_id',$user_id)       
                ->get();        
        return $ques;
    }
}
