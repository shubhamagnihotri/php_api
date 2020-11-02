<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFilesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('files', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id')->nullable();
            $table->integer('consultation_id')->nullable();
            $table->string('file_url')->nullable();
            $table->tinyInteger('file_type')->comment('1->image,2->videos')->default(1)->nullable();
            $table->tinyInteger('file_view_from')->comment('0->none,1->left,2->right,3->front,4->back')->default(0)->nullable();

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
        Schema::dropIfExists('files');
    }
}
