<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Warehouse extends Model
{
    protected $fillable =[

        "name", "phone", "email", "address", "is_active"
    ];

    public function product()
    {
    	return $this->hasMany('App\Product');

    }

    public function purchase()
    {
        return $this->hasMany('App\Purchase','warehouse_id','id');

    }

    public function purchasereturn()
    {
        return $this->hasMany('App\ReturnPurchase','warehouse_id','id');

    }

    public function transferout()
    {
        return $this->hasMany('App\Transfer', 'from_warehouse_id','id');

    }

    public function transferin()
    {
        return $this->hasMany('App\Transfer', 'to_warehouse_id','id');

    }

    public function sale()
    {
        return $this->hasMany('App\Sale','warehouse_id','id');

    }

    public function returnsale()
    {
        return $this->hasMany('App\Returns','warehouse_id','id');

    }
}
