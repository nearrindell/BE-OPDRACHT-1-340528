<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class AllergeenModel extends Model
{

    public function sp_GetAllAllergenen()
    {
        return DB::select('CALL Sp_GetAllAllergenen');
    }

    public function sp_CreateAllergeen($name, $description)
    {
        $row = DB::selectOne(
            'CALL sp_CreateAllergeen(:name, :description)', 
            [
                'name' => $name, 
                'description' => $description
            ]
        );
        return $row->new_id;
    }

    public function sp_DeleteAllergeen($id)
    {
        $result = DB::selectOne(
            'CALL sp_DeleteAllergeen(:id)', 
            [
                'id' => $id
            ]);
        return $result->affected ?? 0;
    }

    public function sp_GetAllergeenById($id)
    {
        return DB::selectOne('CALL sp_GetAllergeenById(:id)', [
            'id' => $id
        ]);
    }

    public function sp_UpdateAllergeen($id, $naam, $omschrijving)
    {
        $row = DB::selectOne(
            'CALL sp_UpdateAllergeen(:id, :naam, :omschrijving)', [
                'id' => $id,
                'naam' => $naam,
                'omschrijving' => $omschrijving
            ]
        );

        return $row->affected ?? 0;
    }

}