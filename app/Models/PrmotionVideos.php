<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PrmotionVideos extends Model
{
    //
    protected $fillable = [];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [];
    protected $primaryKey = 'id';
    protected $table = 'promotion_videos';
    public $timestamps = true;


    public function deletePromotionVideo($video_id){
        return PrmotionVideos::where('id', $video_id)               
                ->delete();
    }
}
