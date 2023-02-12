<?php

namespace App\Http\Controllers;

use App\PaymentWithCheque;
use App\PaymentWithCreditCard;
use App\PosSetting;
use App\Sale;
use Illuminate\Http\Request;
use App\Supplier;
use App\Customer;
use App\CustomerGroup;
use App\Purchase;
use App\CashRegister;
use App\Account;
use App\Payment;
use Illuminate\Validation\Rule;
use Auth;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Mail\UserNotification;
use Illuminate\Support\Facades\Mail;
use Stripe\Stripe;

class SupplierController extends Controller
{
    public function index()
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('suppliers-index')){
            $permissions = Role::findByName($role->name)->permissions;
            foreach ($permissions as $permission)
                $all_permission[] = $permission->name;
            if(empty($all_permission))
                $all_permission[] = 'dummy text';
            $lims_supplier_all = Supplier::where('is_active', true)->get();
            $lims_pos_setting_data = PosSetting::select('stripe_public_key')->latest()->first();
            $lims_account_list = Account::where('is_active', true)->get();
            return view('backend.supplier.index',compact('lims_supplier_all', 'all_permission','lims_pos_setting_data','lims_account_list'));
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function clearDue(Request $request)
    {
        $data = $request->all();
        $lims_due_purchase_data = Purchase::select('id', 'warehouse_id', 'total_cost', 'order_discount','shipping_cost', 'grand_total', 'paid_amount', 'payment_status')
                            ->where([
                                ['payment_status', 1],
                                ['supplier_id', $request->supplier_id]
                            ])->get();

        if(isset($data['payment_date'])){
            $data['payment_date'] = date("Y-m-d H:i:s", strtotime($data['payment_date']));
        }
        else{
            $data['payment_date'] = date("Y-m-d H:i:s");
        }
//        dd($lims_due_purchase_data);
        $total_paid_amount = $request->paying_amount;
        foreach ($lims_due_purchase_data as $key => $purchase_data) {
            if($total_paid_amount == 0)
                break;
//            $due_amount = $purchase_data->grand_total - $purchase_data->paid_amount;
            $returned_amount = DB::table('return_purchases')->where('purchase_id', $purchase_data->id)->sum('grand_total');
//            dd($returned_amount);
            $due_amount = (($purchase_data->total_cost - $purchase_data->order_discount)- $returned_amount  - $purchase_data->paid_amount);
//            dd($due_amount);
            $lims_cash_register_data =  CashRegister::select('id')
                                        ->where([
                                            ['user_id', Auth::id()],
                                            ['warehouse_id', $purchase_data->warehouse_id],
                                            ['status', 1]
                                        ])->first();
            if($lims_cash_register_data)
                $cash_register_id = $lims_cash_register_data->id;
            else
                $cash_register_id = null;
            $account_data = Account::select('id')->where('id', $data['account_id'])->first();
            if($total_paid_amount >= $due_amount) {
                $paid_amount = $due_amount;
                $payment_status = 2;
            }
            else {
                $paid_amount = $total_paid_amount;
                $payment_status = 1;
            }

            if($request->paid_by_id == 1)
                $paying_method = 'Cash';
            elseif ($request->paid_by_id == 2)
                $paying_method = 'Gift Card';
            elseif ($request->paid_by_id == 3)
                $paying_method = 'Credit Card';
            else
                $paying_method = 'Cheque';

            Payment::create([
                'payment_reference' => 'ppr-'.date("Ymd").'-'.date("his"),
                'purchase_id' => $purchase_data->id,
                'user_id' => Auth::id(),
                'cash_register_id' => $cash_register_id,
                'account_id' => $account_data->id,
                'amount' => $paid_amount,
                'change' => $data['receive_amount'] - $data['paying_amount'],
                'paying_method' => $paying_method,
                'payment_note' => $request->note,
                'payment_date' => $data['payment_date']
            ]);

            $lims_payment_data = Payment::latest()->first();
            $data['payment_id'] = $lims_payment_data->id;

            if($paying_method == 'Credit Card'){
                $lims_pos_setting_data = PosSetting::latest()->first();
                Stripe::setApiKey($lims_pos_setting_data->stripe_secret_key);
                $token = $data['stripeToken'];
                $amount = $data['paying_amount'];

                // Charge the Customer
                $charge = \Stripe\Charge::create([
                    'amount' => $amount * 100,
                    'currency' => 'usd',
                    'source' => $token,
                ]);

                $data['charge_id'] = $charge->id;
                PaymentWithCreditCard::create($data);
            }
            elseif ($paying_method == 'Cheque') {
                PaymentWithCheque::create($data);
            }

            $purchase_data->paid_amount += $paid_amount;
            $purchase_data->payment_status = $payment_status;
            $purchase_data->save();
            $total_paid_amount -= $paid_amount;
        }
        return redirect()->back()->with('message', 'Due cleared successfully');
    }

    public function create()
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('suppliers-add')){
            $lims_customer_group_all = CustomerGroup::where('is_active',true)->get();
            return view('backend.supplier.create', compact('lims_customer_group_all'));
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'company_name' => [
                'max:255',
                    Rule::unique('suppliers')->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ],
            'email' => [
                    Rule::unique('suppliers')->where(function ($query) {
                    return $query->where('is_active', 1)->whereNotNull('email');
                }),
            ],
            'image' => 'image|mimes:jpg,jpeg,png,gif|max:100000',
        ]);

        //validation for customer if create both user and supplier
        if(isset($request->both)) {
            $this->validate($request, [
                'phone_number' => [
                    'max:255',
                    Rule::unique('customers')->where(function ($query) {
                        return $query->where('is_active', 1);
                    }),
                ],
            ]);
        }

        $lims_supplier_data = $request->except('image');
        $lims_supplier_data['is_active'] = true;
        $image = $request->image;
        if ($image) {
            $ext = pathinfo($image->getClientOriginalName(), PATHINFO_EXTENSION);
            $imageName = preg_replace('/[^a-zA-Z0-9]/', '', $request['company_name']);
            $imageName = $imageName . '.' . $ext;
            $image->move('public/images/supplier', $imageName);
            $lims_supplier_data['image'] = $imageName;
        }
        Supplier::create($lims_supplier_data);
        $message = 'Supplier';
        if(isset($request->both)) {
            Customer::create($lims_supplier_data);
            $message .= ' and Customer';
        }
        try{
            Mail::send( 'mail.supplier_create', $lims_supplier_data, function( $message ) use ($lims_supplier_data)
            {
                $message->to( $lims_supplier_data['email'] )->subject( 'New Supplier' );
            });
            $message .= ' created successfully!';
        }
        catch(\Exception $e) {
            $message .= ' created successfully. Please setup your <a href="setting/mail_setting">mail setting</a> to send mail.';
        }
        return redirect('supplier')->with('message', $message);
    }

    public function edit($id)
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('suppliers-edit')){
            $lims_supplier_data = Supplier::where('id',$id)->first();
            return view('backend.supplier.edit',compact('lims_supplier_data'));
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'company_name' => [
                'max:255',
                    Rule::unique('suppliers')->ignore($id)->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ],

            'email' => [
                    Rule::unique('suppliers')->ignore($id)->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ],
            'image' => 'image|mimes:jpg,jpeg,png,gif|max:100000',
        ]);

        $input = $request->except('image');
        $image = $request->image;
        if ($image) {
            $ext = pathinfo($image->getClientOriginalName(), PATHINFO_EXTENSION);
            $imageName = preg_replace('/[^a-zA-Z0-9]/', '', $request['company_name']);
            $imageName = $imageName . '.' . $ext;
            $image->move('public/images/supplier', $imageName);
            $input['image'] = $imageName;
        }

        $lims_supplier_data = Supplier::findOrFail($id);
        $lims_supplier_data->update($input);
        return redirect('supplier')->with('message','Data updated successfully');
    }

    public function deleteBySelection(Request $request)
    {
        $supplier_id = $request['supplierIdArray'];
        foreach ($supplier_id as $id) {
            $lims_supplier_data = Supplier::findOrFail($id);
            $lims_supplier_data->is_active = false;
            $lims_supplier_data->save();
        }
        return 'Supplier deleted successfully!';
    }

    public function destroy($id)
    {
        $lims_supplier_data = Supplier::findOrFail($id);
        $lims_supplier_data->is_active = false;
        $lims_supplier_data->save();
        return redirect('supplier')->with('not_permitted','Data deleted successfully');
    }

    public function importSupplier(Request $request)
    {
        $upload=$request->file('file');
        $ext = pathinfo($upload->getClientOriginalName(), PATHINFO_EXTENSION);
        if($ext != 'csv')
            return redirect()->back()->with('not_permitted', 'Please upload a CSV file');
        $filename =  $upload->getClientOriginalName();
        $filePath=$upload->getRealPath();
        //open and read
        $file=fopen($filePath, 'r');
        $header= fgetcsv($file);
        $escapedHeader=[];
        //validate
        foreach ($header as $key => $value) {
            $lheader=strtolower($value);
            $escapedItem=preg_replace('/[^a-z]/', '', $lheader);
            array_push($escapedHeader, $escapedItem);
        }
        //looping through othe columns
        while($columns=fgetcsv($file))
        {
            if($columns[0]=="")
                continue;
            foreach ($columns as $key => $value) {
                $value=preg_replace('/\D/','',$value);
            }
           $data= array_combine($escapedHeader, $columns);

           $supplier = Supplier::firstOrNew(['company_name'=>$data['companyname']]);
           $supplier->name = $data['name'];
           $supplier->image = $data['image'];
           $supplier->vat_number = $data['vatnumber'];
           $supplier->email = $data['email'];
           $supplier->phone_number = $data['phonenumber'];
           $supplier->address = $data['address'];
           $supplier->city = $data['city'];
           $supplier->state = $data['state'];
           $supplier->postal_code = $data['postalcode'];
           $supplier->country = $data['country'];
           $supplier->is_active = true;
           $supplier->save();
           $message = 'Supplier Imported Successfully';
           if($data['email']){
                try{
                    Mail::send( 'mail.supplier_create', $data, function( $message ) use ($data)
                    {
                        $message->to( $data['email'] )->subject( 'New Supplier' );
                    });
                }
                catch(\Excetion $e){
                    $message = 'Supplier imported successfully. Please setup your <a href="setting/mail_setting">mail setting</a> to send mail.';
                }
            }
        }
        return redirect('supplier')->with('message', $message);
    }

    public function getPayment($id)
    {
        $lims_supplier_list = Purchase::where('supplier_id', $id)->get();

        $date = [];
        $payment_reference = [];
        $paid_amount = [];
        $paying_method = [];
        $payment_id = [];
        $payment_note = [];
        $cheque_no = [];
        $change = [];
        $paying_amount = [];
        $account_name = [];
        $account_id = [];
        foreach ($lims_supplier_list as $all_purchase) {

            $purchase_id = $all_purchase->id;
            $lims_payment_list = Payment::where('purchase_id',$purchase_id)->get();

            foreach ($lims_payment_list as $payment) {
                $date[] =  date("d M, Y", strtotime($payment->payment_date));
                $payment_reference[] = $payment->payment_reference;
                $paid_amount[] = $payment->amount;
                $change[] = $payment->change;
                $paying_method[] = $payment->paying_method;
                $paying_amount[] = $payment->amount + $payment->change;
                if ($payment->paying_method == 'Cheque') {
                    $lims_payment_cheque_data = PaymentWithCheque::select('cheque_no')->where('payment_id', $payment->id)->first();
//                    dd($lims_payment_cheque_data);
                    $cheque_no[] = $lims_payment_cheque_data;
                } else {
                    $cheque_no[] = null;
                }
                $payment_id[] = $payment->id;
                $payment_note[] = $payment->payment_note;
                $lims_account_data = Account::find($payment->account_id);
                $account_name[] = $lims_account_data->name;
                $account_id[] = $lims_account_data->id;
            }
        }
        $payments[] = $date;
        $payments[] = $payment_reference;
        $payments[] = $paid_amount;
        $payments[] = $paying_method;
        $payments[] = $payment_id;
        $payments[] = $payment_note;
        $payments[] = $cheque_no;
        $payments[] = $change;
        $payments[] = $paying_amount;
        $payments[] = $account_name;
        $payments[] = $account_id;

        return $payments;
    }
}
