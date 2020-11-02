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
    Route::post('update_forget_password','API\OnboardingController@updateForgetPassword');
    Route::get('get_ethnicity','API\OnboardingController@getEthnicity');
    Route::get('get_countries','API\OnboardingController@getCountries');
    Route::post('get_countries_states','API\OnboardingController@getCountriesStates');
    
Route::group(['middleware' => ['verify.authUser']], function(){
    Route::post('update_profile','API\OnboardingController@updateProfile');
    Route::get('userProfile', 'API\OnboardingController@userProfile');
    Route::get('test', 'API\OnboardingController@test');
  
    Route::match(['GET','POST'],'get_question_and_submit_answer','API\QuestionnaireController@getQuestionAndSubmitAnswer');
  
    Route::match(['POST'],'check_and_get_sub_question','API\QuestionnaireController@checkAndGetSubQuestion');

    // get all consultation 
    Route::match(['POST'],'get_consultaion_detail','API\QuestionnaireController@getConsultaionDetail');

    Route::match(['GET'],'get_consultaion_detail/{id}','API\QuestionnaireController@getConsultaionFullDetail');

    //add consulation feedback from user 
    Route::match(['POST'],'add_consultation_feedback','API\QuestionnaireController@addConsultationFeedback');

     //add consulation feedback from user 
     Route::match(['POST'],'add_consultation_appointment','API\QuestionnaireController@addConsultationAppointment');
});
//close verify.authUser middleware 

// for admin console apis
Route::group(['middleware' => ['verify.authUser'],'prefix' => 'admin'], function(){
    // get consultation queue
    Route::post('get_consultation_queue','API\AdminController@getConsultationQueue');
    Route::get('get_consultation_queue/{id}','API\AdminController@getConsultationFullDetail');
    Route::post('generate_car/{id}','API\AdminController@generateCar');
    Route::post('add_consultation_notes/{id}','API\AdminController@addConsultationNotes');
    Route::post('get_generated_car_detail/{id}','API\AdminController@getGeneratedCarDetail');
});

});
//close v1 prefix 