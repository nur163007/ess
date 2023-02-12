<?php

namespace App\Http\Controllers;

use App\PaymentWithCheque;
use App\PaymentWithCreditCard;
use App\PosSetting;
use Illuminate\Http\Request;
use App\CustomerGroup;
use App\Customer;
use App\Deposit;
use App\User;
use App\Supplier;
use App\Sale;
use App\Payment;
use App\CashRegister;
use App\Account;
use Auth;
use DB;
use Illuminate\Validation\Rule;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Mail\UserNotification;
use Illuminate\Support\Facades\Mail;
use Stripe\Stripe;
use function Doctrine\Common\Cache\Psr6\get;

class CustomerController extends Controller
{
    public function index()
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('customers-index')){
            $permissions = Role::findByName($role->name)->permissions;
            foreach ($permissions as $permission)
                $all_permission[] = $permission->name;
            if(empty($all_permission))
                $all_permission[] = 'dummy text';
            $lims_account_list = Account::where('is_active', true)->get();
            $lims_pos_setting_data = PosSetting::select('stripe_public_key')->latest()->first();
            $lims_customer_all = Customer::with('customerGroup')->where('is_active', true)->get();

            return view('backend.customer.index', compact('lims_customer_all', 'all_permission','lims_account_list','lims_pos_setting_data'));
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function clearDue(Request $request)
    {
        $data = $request->all();
        $lims_due_sale_data = Sale::select('id', 'warehouse_id','total_price','order_discount', 'grand_total', 'paid_amount', 'payment_status')
                            ->where([
                                ['payment_status', '!=', 4],
                                ['customer_id', $request->customer_id]
                            ])->get();
        $lims_customer_data = Customer::find($request->customer_id);
//        dd($lims_customer_data);

        if(isset($data['payment_date'])){
            $data['payment_date'] = date("Y-m-d H:i:s", strtotime($data['payment_date']));
        }
        else{
            $data['payment_date'] = date("Y-m-d H:i:s");
        }

//        dd($lims_due_sale_data);
        $total_paid_amount = $request->paying_amount;
        foreach ($lims_due_sale_data as $key => $sale_data) {
            if($total_paid_amount == 0)
                break;
            $returned_amount = DB::table('returns')->where('sale_id', $sale_data->id)->sum('grand_total');
//            dd($sale_data->total_price);
            $due_amount = (($sale_data->total_price - $sale_data->order_discount)- $returned_amount  - $sale_data->paid_amount);
//            $due_amount = $sale_data->grand_total - $sale_data->paid_amount;
//            dd($due_amount);
            $lims_cash_register_data =  CashRegister::select('id')
                                        ->where([
                                            ['user_id', Auth::id()],
                                            ['warehouse_id', $sale_data->warehouse_id],
                                            ['status', 1]
                                        ])->first();
            if($lims_cash_register_data)
                $cash_register_id = $lims_cash_register_data->id;
            else
                $cash_register_id = null;
            $account_data = Account::select('id')->where('id', $data['account_id'])->first();
            if($total_paid_amount >= $due_amount) {
                $paid_amount = $due_amount;
                $payment_status = 4;
            }
            else {
                $paid_amount = $total_paid_amount;
                $payment_status = 2;
            }

            if($request->paid_by_id == 1)
                $paying_method = 'Cash';
            elseif ($request->paid_by_id == 2)
                $paying_method = 'Gift Card';
            elseif ($request->paid_by_id == 3)
                $paying_method = 'Credit Card';
            elseif($request->paid_by_id == 6)
                $paying_method = 'Deposit';
            else
                $paying_method = 'Cheque';

            Payment::create([
                'payment_reference' => 'spr-'.date("Ymd").'-'.date("his"),
                'sale_id' => $sale_data->id,
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
            elseif ($paying_method == 'Deposit') {
                $lims_customer_data->expense += $data['paying_amount'];
                $lims_customer_data->save();
            }

            $sale_data->paid_amount += $paid_amount;
            $sale_data->payment_status = $payment_status;
            $sale_data->save();
            $total_paid_amount -= $paid_amount;
        }
        return redirect()->back()->with('message', 'Due cleared successfully');
    }

    public function create()
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('customers-add')){
            $lims_customer_group_all = CustomerGroup::where('is_active',true)->get();
            return view('backend.customer.create', compact('lims_customer_group_all'));
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'phone_number' => [
                'max:255',
                Rule::unique('customers')->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ],
        ]);
        //validation for supplier if create both user and supplier
        if(isset($request->both)) {
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
            ]);
        }
        //validation for user if given user access
        if(isset($request->user)) {
            $this->validate($request, [
                'name' => [
                    'max:255',
                        Rule::unique('users')->where(function ($query) {
                        return $query->where('is_deleted', false);
                    }),
                ],
                'email' => [
                        Rule::unique('users')->where(function ($query) {
                        return $query->where('is_deleted', false)->whereNotNull('email');
                    }),
                ],
            ]);
        }
        $lims_customer_data = $request->all();
        $lims_customer_data['is_active'] = true;
        $message = 'Customer';
        if(isset($request->user)) {
            $lims_customer_data['phone'] = $lims_customer_data['phone_number'];
            $lims_customer_data['role_id'] = 5;
            $lims_customer_data['is_deleted'] = false;
            $lims_customer_data['password'] = bcrypt($lims_customer_data['password']);
            $user = User::create($lims_customer_data);
            $lims_customer_data['user_id'] = $user->id;
            $message .= ', User';
        }
        $lims_customer_data['name'] = $lims_customer_data['customer_name'];
        if(isset($request->both)) {
            Supplier::create($lims_customer_data);
            $message .= ' and Supplier';
        }

        if($lims_customer_data['email']) {
            try{
                Mail::send( 'mail.customer_create', $lims_customer_data, function( $message ) use ($lims_customer_data)
                {
                    $message->to( $lims_customer_data['email'] )->subject( 'New Customer' );
                });
            }
            catch(\Exception $e){
                $message .= ' created successfully. Please setup your <a href="setting/mail_setting">mail setting</a> to send mail.';
            }
        }
        else
            $message .= ' created successfully!';

        Customer::create($lims_customer_data);
        if($lims_customer_data['pos'])
            return redirect('pos')->with('message', $message);
        else
            return redirect('customer')->with('create_message', $message);
    }

    public function edit($id)
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('customers-edit')){
            $lims_customer_data = Customer::find($id);
            $lims_customer_group_all = CustomerGroup::where('is_active',true)->get();
            return view('backend.customer.edit', compact('lims_customer_data','lims_customer_group_all'));
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function update(Request $request, $id)
    {
        $input = $request->all();
        $lims_customer_data = Customer::find($id);

        $this->validate($request, [
            'phone_number' => [
                'max:255',
                Rule::unique('customers')->ignore($id)->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ],
        ]);

        if(isset($input['user'])) {
            $this->validate($request, [
                'name' => [
                    'max:255',
                        Rule::unique('users')->where(function ($query) {
                        return $query->where('is_deleted', false);
                    }),
                ],
                'email' => [
                        Rule::unique('users')->where(function ($query) {
                        return $query->where('is_deleted', false)->whereNotNull('email');
                    }),
                ],
            ]);

            $input['phone'] = $input['phone_number'];
            $input['role_id'] = 5;
            $input['is_active'] = true;
            $input['is_deleted'] = false;
            $input['password'] = bcrypt($input['password']);
            $user = User::create($input);
            $input['user_id'] = $user->id;
            $message = 'Customer updated and user created successfully';
        }
        else {
            $message = 'Customer updated successfully';
        }

        $input['name'] = $input['customer_name'];
        $lims_customer_data->update($input);
        return redirect('customer')->with('edit_message', $message);
    }

    public function importCustomer(Request $request)
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('customers-add')){
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
               $lims_customer_group_data = CustomerGroup::where('name', $data['customergroup'])->first();
               $customer = Customer::firstOrNew(['name'=>$data['name']]);
               $customer->customer_group_id = $lims_customer_group_data->id;
               $customer->name = $data['name'];
               $customer->company_name = $data['companyname'];
               $customer->email = $data['email'];
               $customer->phone_number = $data['phonenumber'];
               $customer->address = $data['address'];
               $customer->city = $data['city'];
               $customer->state = $data['state'];
               $customer->postal_code = $data['postalcode'];
               $customer->country = $data['country'];
               $customer->is_active = true;
               $customer->save();
               $message = 'Customer Imported Successfully';
               if($data['email']){
                    try{
                        Mail::send( 'mail.customer_create', $data, function( $message ) use ($data)
                        {
                            $message->to( $data['email'] )->subject( 'New Customer' );
                        });
                    }
                    catch(\Exception $e){
                        $message = 'Customer imported successfully. Please setup your <a href="setting/mail_setting">mail setting</a> to send mail.';
                    }
                }
            }
            return redirect('customer')->with('import_message', $message);
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    public function getDeposit($id)
    {
        $lims_deposit_list = Deposit::where('customer_id', $id)->get();
        $deposit_id = [];
        $deposits = [];
        foreach ($lims_deposit_list as $deposit) {
            $deposit_id[] = $deposit->id;
            $date[] = date("d-m-y", strtotime($deposit->deposit_date));
            $amount[] = $deposit->amount;
            $lims_account_data = Account::find($deposit->account_id);
            $account_name[] = $lims_account_data->name;
            $account_id[] = $deposit->account_id;
            $note[] = $deposit->note;
            $lims_user_data = User::find($deposit->user_id);
            $name[] = $lims_user_data->name;
            $email[] = $lims_user_data->email;
        }
        if(!empty($deposit_id)){
            $deposits[] = $deposit_id;
            $deposits[] = $date;
            $deposits[] = $amount;
            $deposits[] = $account_name;
            $deposits[] = $note;
            $deposits[] = $name;
            $deposits[] = $email;
            $deposits[] = $account_id;
        }
        return $deposits;
    }

    public function addDeposit(Request $request)
    {
        $data = $request->all();
        $data['user_id'] = Auth::id();
        $lims_customer_data = Customer::find($data['customer_id']);
        $lims_customer_data->deposit += $data['amount'];
        $lims_customer_data->save();
        if(isset($data['deposit_date'])){
            $data['deposit_date'] = date("Y-m-d H:i:s", strtotime($data['deposit_date']));
        }
        else{
            $data['deposit_date'] = date("Y-m-d H:i:s");
        }
        Deposit::create($data);
        $message = 'Data inserted successfully';
        if($lims_customer_data->email){
            $data['name'] = $lims_customer_data->name;
            $data['email'] = $lims_customer_data->email;
            $data['balance'] = $lims_customer_data->deposit - $lims_customer_data->expense;
            try{
                Mail::send( 'mail.customer_deposit', $data, function( $message ) use ($data)
                {
                    $message->to( $data['email'] )->subject( 'Recharge Info' );
                });
            }
            catch(\Exception $e){
                $message = 'Data inserted successfully. Please setup your <a href="setting/mail_setting">mail setting</a> to send mail.';
            }
        }
        return redirect('customer')->with('create_message', $message);
    }

    public function updateDeposit(Request $request)
    {
        $data = $request->all();
        $lims_deposit_data = Deposit::find($data['deposit_id']);
        $lims_customer_data = Customer::find($lims_deposit_data->customer_id);
        $amount_dif = $data['amount'] - $lims_deposit_data->amount;
        $lims_customer_data->deposit += $amount_dif;
        $lims_customer_data->save();
        if(isset($data['deposit_date'])){
            $data['deposit_date'] = date("Y-m-d H:i:s", strtotime($data['deposit_date']));
        }
        else{
            $data['deposit_date'] = date("Y-m-d H:i:s");
        }
        $lims_deposit_data->update($data);
        return redirect('customer')->with('create_message', 'Data updated successfully');
    }

    public function deleteDeposit(Request $request)
    {
        $data = $request->all();
        $lims_deposit_data = Deposit::find($data['id']);
        $lims_customer_data = Customer::find($lims_deposit_data->customer_id);
        $lims_customer_data->deposit -= $lims_deposit_data->amount;
        $lims_customer_data->save();
        $lims_deposit_data->delete();
        return redirect('customer')->with('not_permitted', 'Data deleted successfully');
    }

    public function deleteBySelection(Request $request)
    {
        $customer_id = $request['customerIdArray'];
        foreach ($customer_id as $id) {
            $lims_customer_data = Customer::find($id);
            $lims_customer_data->is_active = false;
            $lims_customer_data->save();
        }
        return 'Customer deleted successfully!';
    }

    public function destroy($id)
    {
        $lims_customer_data = Customer::find($id);
        $lims_customer_data->is_active = false;
        $lims_customer_data->save();
        return redirect('customer')->with('not_permitted','Data deleted Successfully');
    }

    public function getPayment($id)
    {
        $lims_sale_list = Sale::where('customer_id', $id)->get();

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
        foreach ($lims_sale_list as $all_sale) {

            $sale_id = $all_sale->id;
            $lims_payment_list = Payment::where('sale_id',$sale_id)->get();

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
