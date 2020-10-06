<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });




Route::group(['prefix' =>'v1'], function () {

Route::group(['prefix' => 'auth'], function () {
    
Route::post('login', 'API\OnboardingController@login');
Route::group(['middleware' => ['auth:api','verify.authUser']], function(){
    Route::post('logout', 'API\OnboardingController@logout');
    Route::post('refresh', 'API\OnboardingController@refresh');
});
//close auth:api,verify.authUser middleware 

});
//close auth prefix

    Route::post('generate_otp','API\OnboardingController@generateOtp');
    Route::post('validate_otp','API\OnboardingController@validateOtp');
    Route::post('generate_password','API\OnboardingController@generatePassword');
    Route::post('social_media_signUp','API\OnboardingController@socialMediaSignUp');
    Route::post('social_media_login','API\OnboardingController@socialMediaLogin');
    Route::post('forget_password','API\OnboardingController@forgetPassword');

    
Route::group(['middleware' => ['verify.authUser']], function(){
    Route::post('update_profile','API\OnboardingController@updateProfile');
    Route::get('userProfile', 'API\OnboardingController@userProfile');
    Route::get('test', 'API\OnboardingController@test');
});
//close verify.authUser middleware 

});
//close v1 prefix 