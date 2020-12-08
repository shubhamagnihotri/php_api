<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ques', function (Blueprint $table) {
            $table->id();
            $table->string('ques_title')->nullable();
            $table->enum('ques_option_type',[1,2,3,4,5,6,7,8])->comment('1 ->Multiple choice (radio) 2 ->Checkbox 3 ->input 4 ->label (static page) 5-> car (dropdown) 6-> date 7-> time 8->image radio')->default(1)->nullable();
            $table->integer('ques_ordering_id')->comment('question_ordering_id for sorting')->nullable();
            $table->integer('ques_parent_option_id')->comment('0->nothing ,if option have sub question')->default(0)->nullable();
            $table->tinyInteger('is_sub_question')->comment('0=>not sub question,1=>subquestion')->default(0)->nullable();
            $table->tinyInteger('is_last_question')->comment('0->not last, 1->last')->default(0)->nullable();
            $table->tinyInteger('ques_status')->comment('0->incative ,1->active')->default(1)->nullable();
            $table->tinyInteger('is_use_existing_car')->comment('0>no 1->list of all existing car')->default(0)->nullable();
            $table->string('from_age_condition')->default(0)->nullable();
            $table->string('to_age_condition')->default(0)->nullable();

            // $table->tinyInteger('option_field_type')->comment('1=>radio,2=>checkbox')->default(1);
            // $table->integer('check_condition_id')->comment('0-> no checking ondition')->default(0)->nullable();
            // $table->integer('condition_true_next_question_id')->comment('if any condition apply and true')->default(0)->nullable();
            // $table->integer('condition_false_next_question_id')->comment('if any condition apply and true')->default(0)->nullable();
            // $table->integer('question_ordering_id')->comment('question_ordering_id for sorting')->nullable();
            // $table->enum('open_next_question_by_reference',['option','question'])->comment('m=male,f=female,t=transgender,o=others')->nullable();
            // $table->integer('next_question_reference_id')->comment('question_ordering_id for sorting')->default(0)->nullable();
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
        Schema::dropIfExists('ques');
    }
}
