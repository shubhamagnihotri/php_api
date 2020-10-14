<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CountryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('countries')->delete();
        DB::table('countries')->insert([
            ['id' => 231, 'country_short_name' => 'US','country_name'=>'United States','phonecode'=>1]
        ]);
        DB::table('country_states')->delete();
        DB::table('country_states')->insert([
            ['id' => 1, 'state_name' => 'Alabama','country_id'=>231],
            ['id' => 2, 'state_name' => 'Alaska','country_id'=>231],
            ['id' => 3, 'state_name' => 'Arizona','country_id'=>231],
            ['id' => 4, 'state_name' => 'Arkansas','country_id'=>231],
            ['id' => 5, 'state_name' => 'Byram','country_id'=>231],
            ['id' => 6, 'state_name' => 'California','country_id'=>231],
            ['id' => 7, 'state_name' => 'Cokato','country_id'=>231],
            ['id' => 8, 'state_name' => 'Connecticut','country_id'=>231],
            ['id' => 9, 'state_name' => 'Delaware','country_id'=>231],
            ['id' => 10, 'state_name' => 'District of Columbia','country_id'=>231],
            ['id' => 11, 'state_name' => 'Florida','country_id'=>231],
            ['id' => 12, 'state_name' => 'Georgia','country_id'=>231],
            ['id' => 13, 'state_name' => 'Hawaii','country_id'=>231],
            ['id' => 14, 'state_name' => 'Idaho','country_id'=>231],
            ['id' => 15, 'state_name' => 'Illinois','country_id'=>231],
            ['id' => 16, 'state_name' => 'Indiana','country_id'=>231],
        ]);
    }
}
