<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuesOptionsNextQuestionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ques_options_next_questions', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('option_id');
            $table->bigInteger('next_ques_id');
            $table->tinyInteger('option_type')->comments('0=> deactivate,2=> activate')->default(1)->nullable();
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
        Schema::dropIfExists('ques_options_next_questions');
    }
}
