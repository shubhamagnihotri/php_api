<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppointmentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->date('appointment_date');
            $table->time('appointment_time');
            $table->tinyInteger('appointment_type')->comments('1->intial,2->Follow Up,3->New on Existing,4-> Personalised')->default(0)->nullable();
            // $table->string('appointment_duration')->comments('in minutes');
            $table->tinyInteger('appointment_status')->comments('0->appointment booked,1->completed')->default(0);
            $table->integer('consultation_id');
            $table->integer('user_id');
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
        Schema::dropIfExists('appointments');
    }
}
