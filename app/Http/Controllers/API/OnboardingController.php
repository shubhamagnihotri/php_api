<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Helpers\CustomHelper as Helper;
use App\Services\Onboarding\BusinessLogicService;
use App\Services\Onboarding\ValidationService;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\Country;
use App\Models\CountryState;
use Illuminate\Support\Facades\Storage;
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
    public function getEthnicity(Request $request){
        $a = config('app-config.ethnicity');
        return Helper::constructResponse(false,'',200,$a);
    }

    public function getCountries(Request $request){
        $a = Country::all();
        return Helper::constructResponse(false,'',200,$a);
    }
    public function getCountriesStates(Request $request){
        $a = CountryState::where('country_id',$request->input('country_id'))->get();
        return Helper::constructResponse(false,'',200,$a);
    }

    
    // forget password otp 
    public function forgetPassword(Request $request){
        $isValidationFailed=$this->validationServiceObject->validateGenerateOtp($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
       $response = $this->businessLogicServiceObject->forgetPassword($request->all());
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

    
    // Generate Password
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

    // update forget password
    public function updateForgetPassword(Request $request){
        $isValidationFailed=$this->validationServiceObject->validatePassword($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response = $this->businessLogicServiceObject->updateForgetPassword($request->all());
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
            return Helper::constructResponse(true,'Please enter valid credentials',402,[]);
            
        }
        if(auth()->user()->signup_type == '1'){
            return Helper::constructResponse(false,'Please login with gmail !',401,[]);

        }
        if(auth()->user()->signup_type == '2'){
            return Helper::constructResponse(false,'Please login with facebook !',401,[]);
        }
     
        $userData = $this->createNewToken($token)->original;
        $this->businessLogicServiceObject->updateSessionModel($userData['access_token'],$userData['user']->id);
        $role = $this->businessLogicServiceObject->getRoleByuserId($userData['user']->id);
        $userData['user']->role = $role;
        return Helper::constructResponse(false,'Login successfully !',200,$userData);
      
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

    // google signup
    public function socialMediaSignUp(Request $request){
        $isValidationFailed=$this->validationServiceObject->validateSocialMediaSignUp($request->all());
        if ($isValidationFailed) {
            return response()->json($isValidationFailed, 400);
        }
        $response=$this->businessLogicServiceObject->socialMediaSignUp($request->all());
        if($response['error'] == true){
            return response()->json($response);
        }
        $request->request->add(['password'=>$request->input('social_media_id')]);
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required',
        ]); 
        $token = auth()->attempt($validator->validated());
        $userData = $this->createNewToken($token)->original;
        
        $this->businessLogicServiceObject->updateSessionModel($userData['access_token'], $userData['user']->id);
        $role = $this->businessLogicServiceObject->getRoleByuserId($userData['user']->id);
        $userData['user']->role = $role;
        return Helper::constructResponse(false,'Signup done successfully !',200,$userData);
    }

    public function socialMediaLogin(Request $request)
    {
      
      
        $userDetail = User::where('social_media_id',$request->input('social_media_id'))->first();
       
        if(!$userDetail){
            return Helper::constructResponse(true,'Signup not done',401,[]);
        }
        $request->request->add(['email'=>$userDetail->email]); 
        $request->request->add(['password'=>$request->input('social_media_id')]);
        $validator = Validator::make($request->all(), [
            'social_media_id'=>'required',
            // 'social_email'=>'required',
            'email' => 'required|email',
            'password' => 'required',
        ]);
      
        if ($validator->fails()) {
            return Helper::constructResponse(true,'validation error',400,$validator->errors());
        }

        if (! $token = auth()->attempt($validator->validated())) {
            return Helper::constructResponse(true,'Login not successfullly',402,$userData);    
        }

        if(auth()->user()->signup_type == '0'){
            return Helper::constructResponse(false,'Please login with normal login !',401,[]);
        }
        $userData = $this->createNewToken($token)->original;
        $this->businessLogicServiceObject->updateSessionModel($userData['access_token'],$userData['user']->id);
        $role = $this->businessLogicServiceObject->getRoleByuserId($userData['user']->id);
        $userData['user']->role = $role;
        return Helper::constructResponse(false,'Login successfully !',200,$userData);
      
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
            //return $user;
            return Helper::constructResponse(false,'',200,$user);
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
