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
    public function deleteImageByUser($user_id,$consultation_id,$image_id){
        return Files::where('id', $image_id)
                ->where('consultation_id',$consultation_id)
                ->where('user_id',$user_id)
                ->delete();
    }

    public function getImagePath($image_id){

        return Files::select("file_url")
                ->where('id', $image_id)                
                ->first();

    }
}
