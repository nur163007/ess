<?php

namespace App\Http\Controllers;

use App\Account;
use App\Agency;
use App\CashRegister;
use App\Customer;
use App\Payment;
use App\PaymentWithCheque;
use App\PaymentWithCreditCard;
use App\PosSetting;
use App\Purchase;
use App\Shipping;
use App\Supplier;
use Illuminate\Http\Request;
use Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Validation\Rule;
use Spatie\Permission\Models\Role;
use Stripe\Stripe;

class AgencyController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('agency-index')){
            $permissions = Role::findByName($role->name)->permissions;
            foreach ($permissions as $permission)
                $all_permission[] = $permission->name;
            if(empty($all_permission))
                $all_permission[] = 'dummy text';
            $lims_agency_all = Agency::where('is_active', true)->get();
            $lims_pos_setting_data = PosSetting::select('stripe_public_key')->latest()->first();
            $lims_account_list = Account::where('is_active', true)->get();
            $lims_shipping_all_data = [];
            foreach ($lims_agency_all as $key => $sum_agency){
                $aid = $sum_agency->id;
                $lims_shipping_all_data[$key] = Agency::with('shipping')->where('id',$aid)->first();

            }
//            dd($lims_shipping_all_data);
            return view('backend.agency.index',compact('lims_agency_all', 'all_permission','lims_shipping_all_data','lims_pos_setting_data','lims_account_list'));
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('agency-add')){
//            dd($role);
            return view('backend.agency.create');
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'company_name' => [
                'max:255',
                Rule::unique('agencies')->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ],
            'email' => [
                Rule::unique('agencies')->where(function ($query) {
                    return $query->where('is_active', 1)->whereNotNull('email');
                }),
            ],
            'image' => 'image|mimes:jpg,jpeg,png,gif|max:100000',
        ]);

        if(isset($request->both)) {
            $this->validate($request, [
                'phone_number' => [
                    'max:255',
                    Rule::unique('agencies')->where(function ($query) {
                        return $query->where('is_active', 1);
                    }),
                ],
            ]);
        }

        $lims_agency_data = $request->except('image');
        $lims_agency_data['is_active'] = true;
        $image = $request->image;
        if ($image) {
            $ext = pathinfo($image->getClientOriginalName(), PATHINFO_EXTENSION);
            $imageName = preg_replace('/[^a-zA-Z0-9]/', '', $request['company_name']);
            $imageName = $imageName . '.' . $ext;
            $image->move('public/images/agency', $imageName);
            $lims_agency_data['image'] = $imageName;
        }
        Agency::create($lims_agency_data);
        $message = 'Agency';
        try{
            Mail::send( 'backend.mail.agency_create', $lims_agency_data, function( $message ) use ($lims_agency_data)
            {
                $message->to( $lims_agency_data['email'] )->subject( 'New Agency Create' );
            });
            $message .= ' created successfully!';
        }
        catch(\Exception $e) {
            $message .= ' created successfully. Please setup your <a href="setting/mail_setting">mail setting</a> to send mail.';
        }
        return redirect('agency')->with('message', $message);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $role = Role::find(Auth::user()->role_id);
        if($role->hasPermissionTo('agency-edit')){
            $lims_agency_data = Agency::where('id',$id)->first();
            return view('backend.agency.edit',compact('lims_agency_data'));
        }
        else
            return redirect()->back()->with('not_permitted', 'Sorry! You are not allowed to access this module');
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'company_name' => [
                'max:255',
                Rule::unique('agencies')->ignore($id)->where(function ($query) {
                    return $query->where('is_active', 1);
                }),
            ],

            'email' => [
                Rule::unique('agencies')->ignore($id)->where(function ($query) {
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
            $image->move('public/images/agency', $imageName);
            $input['image'] = $imageName;
        }

        $lims_agency_data = Agency::findOrFail($id);
        $lims_agency_data->update($input);
        return redirect('agency')->with('message','Data updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function deleteBySelection(Request $request)
    {
        $agency_id = $request['agencyIdArray'];
        foreach ($agency_id as $id) {
            $lims_agency_data = Agency::findOrFail($id);
            $lims_agency_data->is_active = false;
            $lims_agency_data->save();
        }
        return 'Agency deleted successfully!';
    }

    public function destroy($id)
    {
        $lims_agency_data = Agency::findOrFail($id);
        $lims_agency_data->is_active = false;
        $lims_agency_data->save();
        return redirect('agency')->with('not_permitted','Data deleted successfully');
    }

    public function clearDue(Request $request)
    {
        $data = $request->all();
        $lims_due_shipping_data = Shipping::where([
                ['payment_status', 0],
                ['agency_id', $request->agency_id]
            ])->get();

        if(isset($data['payment_date'])){
            $data['payment_date'] = date("Y-m-d H:i:s", strtotime($data['payment_date']));
        }
        else{
            $data['payment_date'] = date("Y-m-d H:i:s");
        }

//        dd($lims_due_purchase_data);
        $total_paid_amount = $request->paying_amount;
        foreach ($lims_due_shipping_data as $key => $shipping_data) {
            if($total_paid_amount == 0)
                break;

            $due_amount = ($shipping_data->shipping_cost - $shipping_data->paid_amount);
//            dd($due_amount);

//            $purchase_data = Purchase::where('id',$shipping_data->purchase_id)->first();
//            dd($purchase_data);
            $lims_cash_register_data =  CashRegister::select('id')
                ->where([
                    ['user_id', Auth::id()],
                    ['status', 1]
                ])->first();
            if($lims_cash_register_data)
                $cash_register_id = $lims_cash_register_data->id;
            else
                $cash_register_id = null;

            $account_data = Account::select('id')->where('id', $data['account_id'])->first();
            if($total_paid_amount >= $due_amount) {
                $paid_amount = $due_amount;
                $payment_status = 1;
            }
            else {
                $paid_amount = $total_paid_amount;
                $payment_status = 0;
            }

            if($request->paid_by_id == 1)
                $paying_method = 'Cash';
            elseif ($request->paid_by_id == 2)
                $paying_method = 'Gift Card';
            elseif ($request->paid_by_id == 3)
                $paying_method = 'Credit Card';
            else
                $paying_method = 'Cheque';

//            dd($shipping_data->id);
            if ($shipping_data->purchase_id != null){
                Payment::create([
                    'payment_reference' => 'ppr-'.date("Ymd").'-'.date("his"),
                    'shipping_id' => $shipping_data->id,
                    'user_id' => Auth::id(),
                    'cash_register_id' => $cash_register_id,
                    'account_id' => $account_data->id,
                    'amount' => $paid_amount,
                    'change' => $data['receive_amount'] - $data['paying_amount'],
                    'paying_method' => $paying_method,
                    'payment_note' => $request->note,
                    'payment_date' => $data['payment_date']
                ]);
            }elseif ($shipping_data->transfer_id != null){
                Payment::create([
                    'payment_reference' => 'tpr-'.date("Ymd").'-'.date("his"),
                    'shipping_id' => $shipping_data->id,
                    'user_id' => Auth::id(),
                    'cash_register_id' => $cash_register_id,
                    'account_id' => $account_data->id,
                    'amount' => $paid_amount,
                    'change' => $data['receive_amount'] - $data['paying_amount'],
                    'paying_method' => $paying_method,
                    'payment_note' => $request->note,
                    'payment_date' => $data['payment_date']
                ]);
            }elseif ($shipping_data->sale_id != null){
                Payment::create([
                    'payment_reference' => 'spr-'.date("Ymd").'-'.date("his"),
                    'shipping_id' => $shipping_data->id,
                    'user_id' => Auth::id(),
                    'cash_register_id' => $cash_register_id,
                    'account_id' => $account_data->id,
                    'amount' => $paid_amount,
                    'change' => $data['receive_amount'] - $data['paying_amount'],
                    'paying_method' => $paying_method,
                    'payment_note' => $request->note,
                    'payment_date' => $data['payment_date']
                ]);
            }

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

            $shipping_data->paid_amount += $paid_amount;
            $shipping_data->payment_status = $payment_status;
            $shipping_data->save();


            $total_paid_amount -= $paid_amount;
        }
        return redirect()->back()->with('message', 'Due cleared successfully');
    }

    public function getPayment($id)
    {
        $lims_agency_list = Shipping::where('agency_id', $id)->get();

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
        foreach ($lims_agency_list as $all_agency) {

            $shipping_id = $all_agency->id;
//            dd($shipping_id);
            $lims_payment_list = Payment::where('shipping_id',$shipping_id)->get();
//dd($lims_payment_list);
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
