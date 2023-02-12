<?php

namespace App;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Shipping extends Model
{
    use HasFactory;

    protected $fillable =[

        "reference_no", "user_id","purchase_id","agency_id","transfer_id","sale_id", "shipping_type","shipping_vehicle_no", "shipping_cost"
    ];

    public function agency()
    {
        return $this->belongsTo('App\Agency','agency_id','id');
    }

    public function purchase()
    {
        return $this->belongsTo('App\Purchase','purchase_id','id');

    }
    public function transfer()
    {
        return $this->belongsTo('App\Transfer','transfer_id','id');

    }
    public function producttransfer()
    {
        return $this->belongsTo('App\ProductTransfer','transfer_id');

    }
}
