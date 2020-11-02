<?php

use Illuminate\Database\Seeder;

class ProductAssociatedTypesSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        DB::table('product_associated_types')->delete();
        DB::table('product_associated_types')->insert([
            ['id' => 1, 'type_title' => 'Scalp concern','associated_type'=>1],
            ['id' => 2, 'type_title' => 'Hair thining concern','associated_type'=>1],
            ['id' => 3, 'type_title' => 'Hair loss concern','associated_type'=>1],
            ['id' => 4, 'type_title' => 'Hair fibre concern ','associated_type'=>1],
            ['id' => 5, 'type_title' => 'Extreme','associated_type'=>2],
            ['id' => 6, 'type_title' => 'Moderate Extreme','associated_type'=>2],
            ['id' => 7, 'type_title' => 'Low Extreme','associated_type'=>2],
            ['id' => 8, 'type_title' => 'Nominal','associated_type'=>2],
        ]);

    }
}
