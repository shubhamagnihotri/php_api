<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConsultationNotesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('consultation_notes', function (Blueprint $table) {
            $table->id();
            $table->integer('consultation_id');
            $table->tinyInteger('note_type')->comments('1->initial meeting,2->follow up meeting notes');
            $table->integer('condition_id');
            $table->text('consultation_note');
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
        Schema::dropIfExists('consultation_notes');
    }
}
