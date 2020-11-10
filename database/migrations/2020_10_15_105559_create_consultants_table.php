<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConsultantsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('consultations', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id');
            $table->text('consultations_comments')->nullable();
            $table->dateTime('consultant_created_at')->nullable();
            $table->dateTime('consultant_ended_at')->nullable();
            $table->text('car_report_response')->nullable();
            $table->dateTime('car_report_created_at')->nullable();
            $table->tinyInteger('feedback_rating')->default(0)->nullable();
            $table->text('feedback_text')->nullable();
            $table->text('car_admin_remarks')->nullable();
            $table->integer('concern_type')->nullable();
            $table->integer('condition_type')->nullable();
            $table->tinyInteger('consultant_status')->comments('0->in progress,1->final submitted,2->under review,3-> completed')->default(0)->nullable();
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
        Schema::dropIfExists('consultants');
    }
}
