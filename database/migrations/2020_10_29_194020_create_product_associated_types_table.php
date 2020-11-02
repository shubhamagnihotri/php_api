<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductAssociatedTypesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('product_associated_types', function (Blueprint $table) {
            $table->id();
            $table->string('type_title');
            $table->tinyInteger('associated_type')->comment('1->concern type (Scalp conscern),2->condition type');
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
        Schema::dropIfExists('product_associated_types');
    }
}
