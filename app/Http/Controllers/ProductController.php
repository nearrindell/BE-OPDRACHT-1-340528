<?php

namespace App\Http\Controllers;

use App\Models\ProductModel;
use Illuminate\Http\Request;


class ProductController extends Controller
{
    private $productModel;

    public function __construct()
    {
       $this->productModel = new ProductModel();
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products = $this->productModel->sp_GetAllProducts();

        return view('product.index', [
            'title' => 'Overzicht Magazijn Jamin',
            'products' => $products
        ]);
    }

    public function allergenenInfo()
    {
        return view('product.allergeenInfo', [
            'title' => 'Allergeen Informatie'
        ]);
    }

     public function leverantieInfo()
    {
        return view('product.leverantieInfo', [
            'title' => 'Leverantie Informatie'
        ]);
    }
}