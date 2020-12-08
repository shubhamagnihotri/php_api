<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuesOptionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ques_options', function (Blueprint $table) {
            $table->id();
            $table->string('option_title')->nullable();
            $table->integer('option_ques_id')->nullable();
         
            $table->tinyInteger('option_status')->comment('0->incative ,1->active')->default(1)->nullable();
            $table->string('option_link')->comment('link if any')->nullable(); 
            $table->string('option_image')->comment('image url')->nullable();
            $table->integer('option_check_condition_id')->default(0)->nullable();
            $table->integer('product_associated_type_id')->default(0)->nullable();
            $table->integer('option_condition_true_next_question_id')->default(0)->nullable();
            $table->integer('option_condition_false_next_question_id')->default(0)->nullable();

            // $table->string('option_value')->nullable();
            // $table->bigInteger('ques_id');
            // $table->tinyInteger('option_type')->comments('1=>input,2=> images')->default(1)->nullable();
            // $table->string('option_field_type')->default('radio')->comments('radio,checkbox')->nullable();
            // $table->tinyInteger('parent_id')->default(0)->comments('0=>no suboption, 1=>sub option (firstlevel),2=> sub option (2 level),3=> sub option (3 level)')->nullable();
            // $table->tinyInteger('option_status')->default(1)->comments('0=>deactivate,1=> activated')->nullable();
            // $table->text('ques_options_comments')->nullable();
            // $table->tinyInteger('is_sub_question')->default(0)->nullable();
            // $table->bigInteger('prev_ques_id')->nullable();
            // $table->bigInteger('next_ques_id')->nullable();
            // $table->enum('gender_type',['o','f'])->default('o')->comment('o=others,f=female')->nullable();
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
        Schema::dropIfExists('ques_options');
    }
}
