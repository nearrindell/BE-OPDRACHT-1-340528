<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ProductModel extends Model
{
    public function sp_GetAllProducts()
    {
        return DB::select('CALL sp_GetAllProducts()');
    }
}