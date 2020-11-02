<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuesAnswersConsultantTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ques_answers_consultations', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('ques_id');
            $table->bigInteger('option_id');
            $table->text('ques_answers_comments')->nullable();
            $table->text('question_for_admin')->nullable();
            $table->string('answer_for_admin')->nullable();
            $table->bigInteger('consultant_id');
            $table->tinyInteger('ques_anser_status')->default(1)->nullable();
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
        Schema::dropIfExists('ques_answers_consultant');
    }
}
