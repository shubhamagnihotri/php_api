<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helpers\CustomHelper as Helper;
use App\Services\Onboarding\BusinessLogicService;
use App\Services\Onboarding\ValidationService;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

use Validator;
class OnboardingController extends Controller
{
    public function __construct()
    {
        $this->validationServiceObject = new ValidationService();
        $this->businessLogicServiceObject = new BusinessLogicService();
       
    }


    // gnerate email otp 
    public function generateOtp(Request $request){
        $isValidationFailed=$this->validationServiceObject->validateGenerateOtp($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
       $response = $this->businessLogicServiceObject->generateOtp($request->all());
       return response()->json($response);
    }

    // validate email otp 
    public function validateOtp(Request $request){
        $isValidationFailed=$this->validationServiceObject->validateEmailOtp($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
       $response = $this->businessLogicServiceObject->validateOtp($request->all());
       return response()->json($response);
    }

    
    // generatePassword
    public function generatePassword(Request $request){
      
        $isValidationFailed=$this->validationServiceObject->validatePassword($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
       $response = $this->businessLogicServiceObject->generatePassword($request->all());
        
        if($response['error'] == true){
            return response()->json($response);
        }
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required',
        ]); 
        $token = auth()->attempt($validator->validated());
        $userData = $this->createNewToken($token)->original;
        
        $this->businessLogicServiceObject->updateSessionModel($userData['access_token'], $userData['user']->id);
        $role = $this->businessLogicServiceObject->getRoleByuserId($userData['user']->id);
        $userData['user']->role = $role;
        return Helper::constructResponse(false,'Password set successfully !',200,$userData);
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:8',
        ]);       
        if ($validator->fails()) {
            return Helper::constructResponse(true,'validation error',400,$validator->errors());
        }
        if (! $token = auth()->attempt($validator->validated())) {
            return Helper::constructResponse(true,'Password not matched successfully',402,$userData);
            
        }
        $userData = $this->createNewToken($token)->original;
        $this->businessLogicServiceObject->updateSessionModel($userData['access_token'],$userData['user']->id);
        $role = $this->businessLogicServiceObject->getRoleByuserId($userData['user']->id);
        $userData['user']->role = $role;
        return Helper::constructResponse(false,'Password set successfully !',200,$userData);
      
    }


    // registration of user
    public function updateProfile(Request $request){
     
        $isValidationFailed=$this->validationServiceObject->validateupdateProfile($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->updateProfile($request->all(),$request->user);
        if($response['error'] == true){
            return response()->json($response);
        }
        $user = $this->businessLogicServiceObject->getuserById($request->user->id);
        $role = $this->businessLogicServiceObject->getRoleByuserId($user->id);
        $user->role = $role;
        $response['data'] = $user;
        return response()->json($response);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->createNewToken(auth()->refresh());
    }


    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function userProfile(Request $request) {
      
        if(auth()->user()){
            $user = auth()->user();
            $role = $this->businessLogicServiceObject->getRoleByuserId($user->id);
            $user->role = $role;
            return $user;
        }else{
            return Helper::constructResponse(true,'Unauthorized',402,[]);
        }
    }


    public function test(Request $request) {
      dd($request);
    }


    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function createNewToken($token){
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
           'expires_in' => auth()->factory()->getTTL() * (60*24*365),
            'user' => auth()->user()
        ]);
    }


     /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout(Request $request)
    {
        $this->businessLogicServiceObject->logout($request->token);
        auth()->logout();
        return Helper::constructResponse(false,'Successfully logged out',200,[]);  
    }
    
}
