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

    public function SP_GetLeverancierInfo($productId)
    {
        return DB::select('CALL SP_GetLeverancierInfo(?)', [$productId]);
    }

    public function sp_GetLeverantieInfo($productId)
    {
        return DB::select('CALL sp_GetLeverantieInfo(?)', [$productId]);
    }
}