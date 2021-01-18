<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UtilityController extends Controller
{
    public function __construct()
    {
    
    }

    //Returns the Ager from DOB    
    public function getAgeFromDOB($dob)
    {
        $age = 0;
        if(isset($dob))
        {
            $age = date_diff(date_create($dob), date_create('today'))->y;
        }
        return $age;
    }//eo getAgeFromDOB()

    // Returns the Gender id by gender code
    // AS f returns 1; m returns 2
    public function getGenderIdByShortCode($gender){
        $gender_id = 0;        
        $gender = strtolower($gender);
        switch($gender){
            case 'f':
                $gender_id =1;
                break;
            case 'm':
                $gender_id =2;
                break;
            case 't':
                $gender_id =3;
                break;
            case 'o':
                $gender_id =4;
                break;
        }
        return $gender_id;
    }//eo getGenderIdByShortCode

}
