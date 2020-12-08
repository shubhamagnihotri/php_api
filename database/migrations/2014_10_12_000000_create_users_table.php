<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('fname')->nullable();
            $table->string('lname')->nullable();
            $table->string('email')->nullable();
            $table->string('ethinicity')->nullable();
            $table->enum('gender',['m','f','t','o'])->comment('m=male,f=female,t=transgender,o=others')->nullable();
            $table->string('mobile_number')->unique()->nullable();
            $table->longText('address')->nullable();
            $table->string('state')->nullable();
            $table->string('country')->nullable();
            $table->string('zip_code')->nullable();
            $table->longText('password_reset_token')->nullable();
            $table->timestamp('email_verified_at')->nullable();
            $table->longText('password');
            $table->date('date_of_birth')->nullable();
            $table->string('profile_image')->nullable();
            $table->tinyInteger('signup_type')->default(0)->comment('0=email,1=google,2=facebook');
            $table->string('social_media_id')->nullable();
            $table->tinyInteger('profile_status')->default(0);
            $table->rememberToken();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
