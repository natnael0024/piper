<?php

namespace App\Http\Controllers;

use App\Models\Tbl;
use GuzzleHttp\Psr7\Request as Psr7Request;
use Illuminate\Http\Request;

class TblController extends Controller
{
    public function index()
    {
        $usrs = Tbl::get('name','email');

        return view('home',compact('usrs'));
    }

    public function store(Request $request)
    {
        $usr = Tbl::create($request->all());

        return redirect()->back();
    }
}
