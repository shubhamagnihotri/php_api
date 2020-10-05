<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RolesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('roles')->delete();
        DB::table('roles')->insert([
            ['id' => 1, 'role' => 'NTTPC Super Admin',  'role_description' => 'nttpc_super_admin'],
            ['id' => 2, 'role' => 'SuiteX/S Admin',    'role_description' => 'suitexs_admin'],
        ]);
    }
}
