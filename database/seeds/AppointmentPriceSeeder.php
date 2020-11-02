<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AppointmentPriceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('appointment_prices')->delete();
        DB::table('appointment_prices')->insert([
            ['id' =>1, 'appointment_type_name' => 'Initial Meeting','appointment_price'=>'','appointment_duration'=>'45'],
            ['id' =>2, 'appointment_type_name' => 'Followup Meeting','appointment_price'=>'','appointment_duration'=>'15'],
            ['id' =>3, 'appointment_type_name' => 'Existing follow up','appointment_price'=>'65','appointment_duration'=>'15'],
            ['id' =>4, 'appointment_type_name' => 'Personalized Trichological Consultation','appointment_price'=>'65','appointment_duration'=>'300'],
        ]);
      
      
    }
}
