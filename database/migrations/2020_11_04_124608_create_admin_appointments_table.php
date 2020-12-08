<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAdminAppointmentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('admin_appointments', function (Blueprint $table) {
            $table->id();
            $table->string('appointment_title');
            $table->date('appointment_date');
            $table->string('appointment_time');
            $table->string('appointment_end_time');
            $table->tinyInteger('appointment_type')->comments('1->intial,2->Follow Up,3->New on Existing,4-> Personalised')->default(0)->nullable();
            $table->string('appointment_duration');
            $table->tinyInteger('appointment_status')->comments('1->appointment fix,2->cancel appoin.,3->resedule')->default(1);

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
        Schema::dropIfExists('admin_appointments');
    }
}
