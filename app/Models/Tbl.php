<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tbl extends Model
{
    use HasFactory;

    protected $table = 'tbl';

    protected $fillable = [
        'name',
        'email',
        'pass'
    ];
}
