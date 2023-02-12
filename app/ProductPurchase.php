<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductPurchase extends Model
{
    protected $table = 'product_purchases';
    protected $fillable =[

        "purchase_id", "product_id", "lc_no", "product_batch_id", "variant_id", "imei_number", "qty", "recieved","transfer_qty","remaining", "purchase_unit_id", "net_unit_cost", "discount", "tax_rate", "tax", "total"
    ];
}
