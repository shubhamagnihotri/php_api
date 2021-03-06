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


Route::get('stripe', 'API\PaymentController@stripe');

Route::group(['prefix' =>'v1'], function () {

Route::group(['prefix' => 'auth'], function () {
    
Route::post('login', 'API\OnboardingController@login');

Route::group(['middleware' => ['verify.authUser:2']], function(){
    Route::post('logout', 'API\OnboardingController@logout');
    Route::post('refresh', 'API\OnboardingController@refresh');
});
//close auth:api,verify.authUser middleware 

});
//close auth prefix

    Route::post('generate_otp','API\OnboardingController@generateOtp');
    Route::post('resend_otp','API\OnboardingController@resend_otp');
    Route::post('validate_otp','API\OnboardingController@validateOtp');
    Route::post('generate_password','API\OnboardingController@generatePassword');
    Route::post('social_media_signUp','API\OnboardingController@socialMediaSignUp');
    Route::post('social_media_login','API\OnboardingController@socialMediaLogin');
    Route::post('forget_password','API\OnboardingController@forgetPassword');
    Route::post('update_forget_password','API\OnboardingController@updateForgetPassword');
    Route::get('get_ethnicity','API\OnboardingController@getEthnicity');
    Route::get('get_countries','API\OnboardingController@getCountries');
    Route::post('get_countries_states','API\OnboardingController@getCountriesStates');
    
Route::group(['middleware' => ['verify.authUser:2']], function(){
    Route::post('update_profile','API\OnboardingController@updateProfile');
    Route::post('change_password','API\OnboardingController@ChangePassword');
    Route::get('userProfile', 'API\OnboardingController@userProfile');
    Route::get('test', 'API\OnboardingController@test');

    Route::match(['GET','POST'],'getNextQuestion/{id}/{option_id}','API\QuestionnaireController@getNextQuestion');

    Route::match(['GET','POST'],'get_question_details/{id}','API\QuestionnaireController@getQuestionDetails');
  
    Route::match(['GET','POST'],'get_question_and_submit_answer','API\QuestionnaireController@getQuestionAndSubmitAnswer');
  
    Route::match(['POST'],'check_and_get_sub_question','API\QuestionnaireController@checkAndGetSubQuestion');

    Route::match(['POST'],'uploadConsultationImages','API\QuestionnaireController@uploadConsultationImage');
    Route::match(['DELETE'],'deleteConsultationImages/{image_id}/{consultation_id}','API\QuestionnaireController@deleteConsultationImages');
    Route::match(['GET'],'getConsultationImages/{consultation_id}','API\QuestionnaireController@getConsultationImages');

    // get all consultation 
    Route::match(['POST'],'get_consultaion_detail','API\QuestionnaireController@getConsultaionDetail');

    // get sheduled consultation 
    Route::match(['POST'],'get_sheduled_appointments','API\QuestionnaireController@getSheduledAppointments');

    Route::match(['GET'],'get_consultaion_detail/{id}','API\QuestionnaireController@getConsultaionFullDetail');

    //add consulation feedback from user 
    Route::match(['POST'],'add_consultation_feedback','API\QuestionnaireController@addConsultationFeedback');

     //add consulation feedback from user 
     Route::match(['POST'],'add_consultation_appointment','API\QuestionnaireController@addConsultationAppointment');
     Route::match(['POST'],'reschedule_consultation_appointment','API\QuestionnaireController@rescheduleConsultationAppointment');
     Route::match(['POST'],'cancel_appointment/{appointment_id}','API\QuestionnaireController@cancelAppointment');
    // get available appointmnet slots
    Route::match(['POST'],'get_consultation_slots','API\QuestionnaireController@getConsultationSlots');

    Route::post('price_plans/{id}','API\PaymentController@pricePlans');

    Route::match(['GET'],'getStaticPage/{id}','API\QuestionnaireController@getStaticPage');

    Route::post('stripe', 'API\PaymentController@stripePost')->name('stripe.post');

    Route::post('product_by_concern/{id}', 'API\QuestionnaireController@productByConcern')->name('product.concernProduct');

    Route::post('get_prom_video','API\QuestionnaireController@getPromVideo');

});
//close verify.authUser middleware 


//onboarding admin user

Route::group(['prefix' => 'admin'], function(){
    Route::post('auth/login', 'API\OnboardingController@adminLogin');
    Route::post('generate_otp','API\OnboardingController@generateOtp');
    Route::post('validate_otp','API\OnboardingController@validateOtp');
    Route::post('generate_password','API\OnboardingController@generatePassword');
    Route::post('forget_password','API\OnboardingController@forgetPassword');
    Route::post('update_forget_password','API\OnboardingController@updateForgetPassword');
});



// for admin console apis
Route::group(['middleware' => ['verify.authUser:1'],'prefix' => 'admin'], function(){
    //update profile admin
    Route::post('update_profile','API\OnboardingController@updateProfile');
    Route::post('logout', 'API\OnboardingController@logout');

    // get consultation queue
    Route::post('get_consultation_queue','API\AdminController@getConsultationQueue');

    Route::post('get_consultation_count','API\AdminController@getConsultationCount');

    Route::get('get_consultation_queue/{id}','API\AdminController@getConsultationFullDetail');

    Route::post('generate_car/{id}','API\AdminController@generateCar');
    Route::post('add_consultation_notes/{id}','API\AdminController@addConsultationNotes');
    Route::get('get_generated_car_detail/{id}','API\AdminController@getGeneratedCarDetail');

    Route::post('get_users_data','API\AdminController@getUsersData');
    Route::get('get_user_data/{id}','API\AdminController@getUserDetail');
    Route::put('update_profile_status/{id}','API\AdminController@updateProfileStatus');
    Route::get('get_concern_and_condition_type','API\AdminController@getConcernAndConditionType');
    Route::post('add_product','API\AdminController@addProduct');
    Route::post('get_products_by_concern/{id}','API\AdminController@getProductByConcern');
    Route::put('update_product_status/{id}','API\AdminController@updateProductStatus');
    Route::get('get_product_detail/{id}','API\AdminController@getProductDetail');
    Route::post('update_product_detail/{id}','API\AdminController@updateProductDetail');
    Route::delete('delete_product_image/{id}','API\AdminController@deleteProductImage');

    Route::get('get_product_related_consulation/{id}','API\AdminController@getProductRelatedConsulation');

    //delete product not in use
    // Route::get('delete_product_by_id/{id}','API\AdminController@deleteProductById');
    Route::post('add_admin_appointment','API\AdminController@addAdminAppointment');
    Route::post('get_appointment_detail/{id}','API\AdminController@getAppointmentDetail');
    Route::post('update_appointment_status/{id}','API\AdminController@updateAppointmentStatus');
    Route::put('update_appointment_detail/{id}','API\AdminController@updateAdminAppointment');

    Route::post('get_appointments','API\AdminController@getAppointments');
    Route::post('add_question','API\AdminController@addQuestion');
    Route::get('get_question_detail/{id}','API\AdminController@getQuestionDetail');
    Route::get('delete_ques_option/{id}','API\AdminController@deleteQuesOption');
    Route::post('edit_question/{id}','API\AdminController@editQuestion');
    Route::post('update_video','API\AdminController@updateVideo');

    Route::delete('delete_promotion_video/{video_id}','API\AdminController@deletePromotionVideo');

    Route::get('get_prom_video','API\AdminController@getPromVideo');

    Route::get('get_static_pages_details','API\AdminController@getStaticPagesDetails');
    Route::get('get_static_pages_details/{id}','API\AdminController@getStaticPageDetails');
    Route::post('add_static_pages','API\AdminController@addStaticPages');
    Route::delete('delete_static_page/{id}','API\AdminController@deleteStaticPage');
    
    //Static page questions
    Route::get('getQuestionForStaticPage/','API\AdminController@getQuestionForStaticPage');
    Route::get('getOptionOfQuestion/{question_id}','API\AdminController@getOptionOfQuestion');
    
    Route::get('get_all_question','API\AdminController@getRootLevelQuestion');
    Route::post('update_question_linking','API\AdminController@updateQuestionLinking');
    Route::get('get_ques_linking_questions','API\AdminController@getQuesLinkingQuestions');
    Route::delete('delete_question/{id}','API\AdminController@deleteQuestion');

    // recommended product 
    Route::post('recommended_products','API\AdminController@recommendedProducts');

    Route::get('getConfigurableQuestions','API\AdminController@getConfigurableQuestions');

});

Route::post('upload_image','API\AdminController@uploadImage');


});
//close v1 prefix 