<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StaticPages extends Model
{
    //
    protected $hidden = [];
    protected $primaryKey = 'id';
    protected $table = 'static_pages';

    public function getStaticPage($id){
        $page = StaticPages::select("id","page_title","page_content",)
                ->where('id',$id)
                ->first();                    
        return $page;
    }
}


