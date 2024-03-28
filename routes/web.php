<?php

use App\Http\Controllers\TblController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/home',[TblController::class,'index'])->name('index');
