<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // $this->call(UsersTableSeeder::class);
        $this->call(RolesTableSeeder::class);
        $this->call(CountryTableSeeder::class);
        $this->call(QuestionaireTableSeeder::class);
        $this->call(AppointmentPriceSeeder::class);
        $this->call(ProductAssociatedTypesSeeder::class);
    }
}
