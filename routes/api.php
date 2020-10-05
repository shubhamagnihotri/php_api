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
});


    Route::post('generate_otp','API\OnboardingController@generateOtp');
    Route::post('validate_otp','API\OnboardingController@validateOtp');
    Route::post('generate_password','API\OnboardingController@generatePassword');
    
Route::group(['middleware' => ['verify.authUser']], function(){
    Route::post('update_profile','API\OnboardingController@updateProfile');
    Route::get('userProfile', 'API\OnboardingController@userProfile');
    Route::get('test', 'API\OnboardingController@test');
});

});