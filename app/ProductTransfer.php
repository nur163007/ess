<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductTransfer extends Model
{
    protected $table = 'product_transfer';
    protected $fillable =[

        "transfer_id", "product_id","lc_no", "product_batch_id", "variant_id", "imei_number", "qty", "purchase_unit_id", "net_unit_cost", "tax_rate", "tax", "total"
    ];

    public function shipping()
    {
        return $this->hasMany('App\Shipping','transfer_id');
    }
}
