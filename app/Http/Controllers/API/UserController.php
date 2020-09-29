<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helpers\CustomHelper as Helper;
use App\Services\User\BusinessLogicService;
use App\Services\User\ValidationService;

class UserController extends UtilityController
{
    protected $validationServiceObject;
    protected $businessLogicServiceObject;

    public function __construct()
    {
        $this->validationServiceObject = new ValidationService();
        $this->businessLogicServiceObject = new BusinessLogicService();
        parent::__construct();
    }

    public function getuser(Request $request){
       $isValidationFailed=$this->validationServiceObject->test($request->all());
       if ($isValidationFailed) {
        return response()->json($isValidationFailed, 400);
       }
       $apiResponse=$this->businessLogicServiceObject->detailById();
       
       $response = Helper::constructResponse(true,'Success',200,$apiResponse);
       return response()->json($response,400);
    }
}
