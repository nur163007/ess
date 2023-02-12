@extends('backend.layout.main') @section('content')
@if(session()->has('create_message'))
    <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{!! session()->get('create_message') !!}</div>
@endif
@if(session()->has('edit_message'))
    <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('edit_message') }}</div>
@endif
@if(session()->has('import_message'))
    <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{!! session()->get('import_message') !!}</div>
@endif
@if(session()->has('not_permitted'))
  <div class="alert alert-danger alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('not_permitted') }}</div>
@endif

<section>
    <div class="container-fluid">
        @if(in_array("customers-add", $all_permission))
            <a href="{{route('customer.create')}}" class="btn btn-info"><i class="dripicons-plus"></i> {{trans('file.Add Customer')}}</a>&nbsp;
            <a href="#" data-toggle="modal" data-target="#importCustomer" class="btn btn-primary"><i class="dripicons-copy"></i> {{trans('file.Import Customer')}}</a>
        @endif
    </div>
    <div class="table-responsive">
        <table id="customer-table" class="table customerList">
            <thead>
                <tr>
                    <th class="not-exported"></th>
                    <th>{{trans('file.Customer Group')}}</th>
                    <th>{{trans('file.Customer Details')}}</th>
                    <th>{{trans('file.Discount Plan')}}</th>
                    <th>{{trans('file.Reward Points')}}</th>
                    <th>{{trans('file.Deposited Balance')}}</th>
                    <th>{{trans('file.Total Due')}}</th>
                    <th class="not-exported">{{trans('file.action')}}</th>
                </tr>
            </thead>
            <tbody>
                @foreach($lims_customer_all as $key => $customer)
                <?php
                    $returned_amount = DB::table('sales')
                                    ->join('returns', 'sales.id', '=', 'returns.sale_id')
                                    ->where([
                                        ['sales.customer_id', $customer->id],
                                        ['sales.payment_status', '!=', 4]
                                    ])
                                    ->sum('returns.grand_total');
                    $saleData = DB::table('sales')->where([
                                    ['customer_id', $customer->id],
                                    ['payment_status', '!=', 4]
                                ])
                                ->selectRaw('SUM(total_price) as total_cost, SUM(order_discount) as total_discount, SUM(paid_amount) as paid_amount')
                                ->first();
                $depositData = DB::table('deposits')->where('customer_id', $customer->id)->selectRaw('account_id')->first();
                ?>
                <tr data-id="{{$customer->id}}">
                    <td>{{$key}}</td>
                    <td>{{$customer->customerGroup->name}}</td>
                    <td>
                        {{$customer->name}}
                        @if($customer->company_name)
                        <br>{{$customer->company_name}}
                        @endif
                        @if($customer->email)
                        <br>{{$customer->email}}
                        @endif
                        <br>{{$customer->phone_number}}
                        <br>{{$customer->address}}, {{$customer->city}}@if($customer->country) {{','.$customer->country}}@endif
                    </td>
                    <td>
                        @foreach($customer->discountPlans as $index => $discount_plan)
                            @if($index)
                                {{', '.$discount_plan->name}}
                            @else
                                {{$discount_plan->name}}
                            @endif
                        @endforeach
                    </td>
                    <td>{{$customer->points}}</td>
                    <td>{{number_format($customer->deposit - $customer->expense, 2)}}</td>
                    <td>{{number_format(($saleData->total_cost - $saleData->total_discount) - $returned_amount - $saleData->paid_amount, 2)}}</td>
                    <td>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{{trans('file.action')}}
                                <span class="caret"></span>
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu">
                                @if(in_array("customers-edit", $all_permission))
                                <li>
                                    <a href="{{ route('customer.edit', $customer->id) }}" class="btn btn-link"><i class="dripicons-document-edit"></i> {{trans('file.edit')}}</a>
                                </li>
                                @endif
                                @if(in_array("due-report", $all_permission))
                                <li>
                                    {!! Form::open(['route' => 'report.customerDueByDate', 'method' => 'post', 'id' => 'due-report-form']) !!}
                                    <input type="hidden" name="start_date" value="{{date('Y-m-d', strtotime('-30 year'))}}" />
                                    <input type="hidden" name="end_date" value="{{date('Y-m-d')}}" />
                                    <input type="hidden" name="customer_id" value="{{$customer->id}}" />
                                    <button type="submit" class="btn btn-link"><i class="dripicons-pulse"></i> {{trans('file.Due Report')}}</button>
                                    {!! Form::close() !!}
                                </li>
                                @endif
                                <li>
                                    @if($depositData)
                                    <input type="hidden" class="depositId" name="depositId" value="{{ $depositData->account_id }}">
                                    @endif
                                    <button type="button" data-id="{{$customer->id}}" class="clear-due btn btn-link" data-toggle="modal" data-target="#clearDueModal" ><i class="dripicons-brush"></i> {{trans('file.Clear Due')}}</button>
                                </li>
                                <li>
                                    <button type="button" data-id="{{$customer->id}}" class="customer-view-payment btn btn-link" data-toggle="modal" data-target="#customerViewPayment" ><i class="fa fa-eye"></i> {{trans('file.View Payment')}}</button>
                                </li>
                                <li>
                                    <button type="button" data-id="{{$customer->id}}" class="deposit btn btn-link" data-toggle="modal" data-target="#depositModal" ><i class="dripicons-plus"></i> {{trans('file.Add Deposit')}}</button>
                                </li>
                                <li>
                                    <button type="button" data-id="{{$customer->id}}" class="getDeposit btn btn-link"><i class="fa fa-money"></i> {{trans('file.View Deposit')}}</button>
                                </li>
                                <li class="divider"></li>
                                @if(in_array("customers-delete", $all_permission))
                                {{ Form::open(['route' => ['customer.destroy', $customer->id], 'method' => 'DELETE'] ) }}
                                <li>
                                    <button type="submit" class="btn btn-link" onclick="return confirmDelete()"><i class="dripicons-trash"></i> {{trans('file.delete')}}</button>
                                </li>
                                {{ Form::close() }}
                                @endif
                            </ul>
                        </div>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</section>

<div id="importCustomer" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
      <div class="modal-content">
        {!! Form::open(['route' => 'customer.import', 'method' => 'post', 'files' => true]) !!}
        <div class="modal-header">
          <h5 id="exampleModalLabel" class="modal-title">{{trans('file.Import Customer')}}</h5>
          <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
        </div>
        <div class="modal-body">
          <p class="italic"><small>{{trans('file.The field labels marked with * are required input fields')}}.</small></p>
           <p>{{trans('file.The correct column order is')}} (customer_group*, name*, company_name, email, phone_number*, address*, city*, state, postal_code, country) {{trans('file.and you must follow this')}}.</p>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>{{trans('file.Upload CSV File')}} *</label>
                        {{Form::file('file', array('class' => 'form-control','required'))}}
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label> {{trans('file.Sample File')}}</label>
                        <a href="public/sample_file/sample_customer.csv" class="btn btn-info btn-block btn-md"><i class="dripicons-download"></i>  {{trans('file.Download')}}</a>
                    </div>
                </div>
            </div>
            <input type="submit" value="{{trans('file.submit')}}" class="btn btn-primary" id="submit-button">
        </div>
        {!! Form::close() !!}
      </div>
    </div>
</div>

<div id="customerViewPayment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="exampleModalLabel" class="modal-title">{{trans('file.All Payment')}}</h5>
                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
            </div>
            <div class="modal-body">
                <table class="table table-hover customer-payment-list">
                    <thead>
                    <tr>
                        <th>{{trans('file.date')}}</th>
{{--                        <th>{{trans('file.Reference No')}}</th>--}}
                        <th>{{trans('file.Account')}}</th>
                        <th>{{trans('file.Amount')}}</th>
                        <th>{{trans('file.Paid By')}}</th>
{{--                        <th>{{trans('file.action')}}</th>--}}
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot class="tfoot active">
                    <th></th>
                    <th>{{trans('file.Total')}}:</th>
                    <th class="totalPaid">0.00</th>
                    <th></th>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="clearDueModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
      <div class="modal-content">
        {!! Form::open(['route' => 'customer.clearDue', 'method' => 'post', 'class' => 'payment-form']) !!}
        <div class="modal-header">
          <h5 id="exampleModalLabel" class="modal-title">{{trans('file.Clear Due')}}</h5>
          <button type="button" data-dismiss="modal" aria-label="Close" class="close" onclick="closeModal();"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
        </div>
        <div class="modal-body">
          <p class="italic"><small>{{trans('file.The field labels marked with * are required input fields')}}.</small></p>
            <div class="row">
                <input type="hidden" name="balance">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>{{trans('file.Payment Date')}} *</label>
                        <input type="text" name="payment_date" class="form-control date" placeholder="Choose date" required />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>{{trans('file.Recieved Amount')}} *</label>
                        <input type="text" name="receive_amount" class="form-control numkey"  step="any" readonly required>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <input type="hidden" name="customer_id">
                        <label>{{trans('file.Paying Amount')}} *</label>
                        <input type="text" name="paying_amount" step="any" class="form-control" required>
                    </div>
                </div>
                <div class="col-md-6 mt-1">
                    <label>{{trans('file.Change')}} : </label>
                    <p class="change ml-2">0.00</p>
                </div>
                <div class="col-md-6 mt-1">
                    <label>{{trans('file.Payment Method')}}</label>
                    <select name="paid_by_id" class="form-control">
                        <option value="1">Cash</option>
                        <option value="3">Credit Card</option>
                        <option value="4">Cheque</option>
                        <option value="6">Deposit</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label> {{trans('file.Account')}}</label>
                        <select class="form-control selectpicker" name="account_id">
                            @foreach($lims_account_list as $account)
                                @if($account->is_default)
                                    <option selected value="{{$account->id}}">{{$account->name}} [{{$account->account_no}}]</option>
                                @else
                                    <option value="{{$account->id}}">{{$account->name}} [{{$account->account_no}}]</option>
                                @endif
                            @endforeach
                        </select>
                    </div>
                </div>
                <div class="form-group col-md-12 mt-2">
                    <div class="card-element" class="form-control">
                    </div>
                    <div class="card-errors" role="alert"></div>
                </div>
                <div class="col-md-12" id="cheque">
                    <div class="form-group">
                        <label>{{trans('file.Cheque Number')}} *</label>
                        <input type="text" name="cheque_no" class="form-control">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label>{{trans('file.Note')}}</label>
                        <textarea name="note" rows="4" class="form-control"></textarea>
                    </div>
                </div>
            </div>
            <input type="submit" value="{{trans('file.submit')}}" class="btn btn-primary" id="submit-button">

        </div>

      </div>
        {!! Form::close() !!}
      </div>
    </div>

<div id="depositModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
      <div class="modal-content">
        {!! Form::open(['route' => 'customer.addDeposit', 'method' => 'post']) !!}
        <div class="modal-header">
          <h5 id="exampleModalLabel" class="modal-title">{{trans('file.Add Deposit')}}</h5>
          <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
        </div>
          <div class="modal-body">
              <p class="italic"><small>{{trans('file.The field labels marked with * are required input fields')}}.</small></p>
              <div class="row">
                  <div class="col-md-6">
                      <div class="form-group">
                          <label>{{trans('file.Deposit Date')}} *</label>
                          <input type="text" name="deposit_date" class="form-control date" placeholder="Choose date" required />
                      </div>
                  </div>
                  <div class="col-md-6">
                      <div class="form-group">
                          <input type="hidden" name="customer_id">
                          <label>{{trans('file.Amount')}} *</label>
                          <input type="text" name="amount" step="any" class="form-control" required>
                      </div>
                  </div>
                  <div class="col-md-6">
                      <div class="form-group">
                          <label> {{trans('file.Account')}}</label>
                          <select class="form-control selectpicker" name="account_id">
                              @foreach($lims_account_list as $account)
                                  @if($account->is_default)
                                      <option selected value="{{$account->id}}">{{$account->name}} [{{$account->account_no}}]</option>
                                  @else
                                      <option value="{{$account->id}}">{{$account->name}} [{{$account->account_no}}]</option>
                                  @endif
                              @endforeach
                          </select>
                      </div>
                  </div>
              </div>
              <div class="row">
                  <div class="col-md-12">
                      <div class="form-group">
                          <label>{{trans('file.Note')}}</label>
                          <textarea name="note" rows="4" class="form-control"></textarea>
                      </div>
                  </div>
              </div>
              <input type="submit" value="{{trans('file.submit')}}" class="btn btn-primary" id="submit-button">

          </div>
        {!! Form::close() !!}
      </div>
    </div>
</div>

<div id="view-deposit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="exampleModalLabel" class="modal-title">{{trans('file.All Deposit')}}</h5>
                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
            </div>
            <div class="modal-body">
                <table class="table table-hover deposit-list">
                    <thead>
                        <tr>
                            <th>{{trans('file.date')}}</th>
                            <th>{{trans('file.Amount')}}</th>
                            <th>{{trans('file.Account')}}</th>
                            <th>{{trans('file.Note')}}</th>
                            <th>{{trans('file.Created By')}}</th>
                            <th>{{trans('file.action')}}</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="edit-deposit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="exampleModalLabel" class="modal-title">{{trans('file.Update Deposit')}}</h5>
                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
            </div>
            <div class="modal-body">
                {!! Form::open(['route' => 'customer.updateDeposit', 'method' => 'post']) !!}
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{trans('file.Deposit Date')}} *</label>
                            <input type="text" name="deposit_date" class="form-control date" placeholder="Choose date" required />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{trans('file.Amount')}} *</label>
                            <input type="text" name="amount" step="any" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label> {{trans('file.Account')}}</label>
                            <select class="form-control selectpicker" name="account_id">
                                @foreach($lims_account_list as $account)
                                    @if($account->is_default)
                                        <option selected value="{{$account->id}}">{{$account->name}} [{{$account->account_no}}]</option>
                                    @else
                                        <option value="{{$account->id}}">{{$account->name}} [{{$account->account_no}}]</option>
                                    @endif
                                @endforeach
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>{{trans('file.Note')}}</label>
                            <textarea name="note" rows="4" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
                    <input type="hidden" name="deposit_id">
                    <button type="submit" class="btn btn-primary">{{trans('file.update')}}</button>
                {{ Form::close() }}
            </div>
        </div>
    </div>
</div>


@endsection

@push('scripts')
<script type="text/javascript">
    $("ul#people").siblings('a').attr('aria-expanded','true');
    $("ul#people").addClass("show");
    $("ul#people #customer-list-menu").addClass("active");

    function confirmDelete() {
      if (confirm("Are you sure want to delete?")) {
          return true;
      }
      return false;
    }
    var public_key = <?php echo json_encode($lims_pos_setting_data->stripe_public_key) ?>;
    var customer_id = [];
    var user_verified = <?php echo json_encode(env('USER_VERIFIED')) ?>;
    var all_permission = <?php echo json_encode($all_permission) ?>;
    var deposit;
    var depositId;
    var logoUrl = <?php echo json_encode(url('public/logo', $general_setting->site_logo)) ?>;

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

  $(".deposit").on("click", function() {
        var id = $(this).data('id').toString();
        $("#depositModal input[name='customer_id']").val(id);
  });

  $(".clear-due").on("click", function() {
        var id = $(this).data('id').toString();
        $("#clearDueModal input[name='customer_id']").val(id);
      $("#cheque").hide();
      $(".card-element").hide();
      rowindex = $(this).closest('tr').index();
      $('select[name="paid_by_id"]').val(1);
      deposit = $('table.customerList tbody tr:nth-child(' + (rowindex + 1) + ')').find('td:nth-child(6)').text();
      depositId = $('table.customerList tbody tr:nth-child(' + (rowindex + 1) + ')').find('.depositId').val();
      var balance = $('table.customerList tbody tr:nth-child(' + (rowindex + 1) + ')').find('td:nth-child(7)').text();
      balance = parseFloat(balance.replace(/,/g, ''));
      $('input[name="paying_amount"]').val(balance);
      $('input[name="balance"]').val(balance);
      $('input[name="receive_amount"]').val(balance);
  });

    $('select[name="paid_by_id"]').on("change", function() {
        var id = $('select[name="paid_by_id"]').val();
        $('input[name="cheque_no"]').attr('required', false);
        $(".payment-form").off("submit");
        if (id == 3) {
            $.getScript( "public/vendor/stripe/checkout.js" );
            $(".card-element").show();
            $("#cheque").hide();
        } else if (id == 4) {
            $("#cheque").show();
            $(".card-element").hide();
            $('input[name="cheque_no"]').attr('required', true);
        } else if(id == 6){
            $(".card-element").hide();
            $("#cheque").hide();
            $('select[name="account_id"]').val(depositId).change();
            if($('#amount').val() > parseFloat(deposit)){
                alert('Amount exceeds customer deposit! Customer deposit : ' + deposit);
            }
        } else {
            $('select[name="account_id"]').val(7).change();
            $(".card-element").hide();
            $("#cheque").hide();
        }
    });

    $('input[name="paying_amount"]').on("input", function() {
        if( $(this).val() > parseFloat($('input[name="receive_amount"]').val()) ) {
            alert('Paying amount cannot be bigger than recieved amount');
            $(this).val('');
        }
        else if( $(this).val() > parseFloat($('input[name="balance"]').val()) ) {
            alert('Paying amount cannot be bigger than due amount');
            $(this).val('');
        }
        $(".change").text(parseFloat($('input[name="receive_amount"]').val() - $(this).val()).toFixed(2));
    });

    $(document).on('submit', '.payment-form', function(e) {
        if( $('input[name="receive_amount"]').val() < parseFloat($('input[name="paying_amount"]').val()) ) {
            alert('Paying amount cannot be bigger than recieved amount');
            $('input[name="paying_amount"]').val('');
            $(".change").text(parseFloat( $('input[name="receive_amount"]').val() - $('input[name="paying_amount"]').val() ).toFixed(2));
            e.preventDefault();
        }
        if($('input[name="receive_amount"]').val() <=0){
            alert('You have no due amount');
        }
    });

  $(".customer-view-payment").on("click", function () {
      var id = $(this).data('id').toString();
      $.get('customers/getpayment/' + id, function(data) {
          // console.log(data)
          $(".customer-payment-list tbody").remove();
          var newBody = $("<tbody>");
          payment_date  = data[0];
          payment_reference = data[1];
          paid_amount = data[2];
          paying_method = data[3];
          payment_id = data[4];
          payment_note = data[5];
          cheque_no = data[6];
          change = data[7];
          paying_amount = data[8];
          account_name = data[9];
          account_id = data[10];
          var totalPay = 0;

          $.each(payment_date, function(index){
              var newRow = $("<tr>");
              var cols = '';

              cols += '<td>' + payment_date[index] + '</td>';
              /*cols += '<td>' + payment_reference[index] + '</td>';*/
              cols += '<td>' + account_name[index] + '</td>';
              cols += '<td>' + paid_amount[index] + '</td>';
              cols += '<td>' + paying_method[index] + '</td>';

              totalPay +=paid_amount[index];
              newRow.append(cols);
              newBody.append(newRow);
              $("table.customer-payment-list").append(newBody);
          });

          if (totalPay > 0){
              $(".totalPaid").text(totalPay);
          }else{
              $(".totalPaid").text('0.00');
          }
          $('#customerViewPayment').modal('show');
      });
  });

  $(".getDeposit").on("click", function() {
        var id = $(this).data('id').toString();
        $.get('customer/getDeposit/' + id, function(data) {
            $(".deposit-list tbody").remove();
            var newBody = $("<tbody>");
            $.each(data[0], function(index){
                var newRow = $("<tr>");
                var cols = '';

                cols += '<td>' + data[1][index] + '</td>';
                cols += '<td>' + data[2][index] + '</td>';
                if(data[3][index])
                    cols += '<td>' + data[3][index] + '</td>';
                else
                    cols += '<td>N/A</td>';
                if(data[4][index])
                    cols += '<td>' + data[4][index] + '</td>';
                else
                    cols += '<td>N/A</td>';
                cols += '<td>' + data[5][index] + '<br>' + data[6][index] + '</td>';
                cols += '<td><div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{{trans("file.action")}}<span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu"><li><button type="button" class="btn btn-link edit-btn" data-id="' + data[0][index] +'" data-toggle="modal" data-target="#edit-deposit"><i class="dripicons-document-edit"></i> {{trans("file.edit")}}</button></li><li class="divider"></li>{{ Form::open(['route' => 'customer.deleteDeposit', 'method' => 'post'] ) }}<li><input type="hidden" name="id" value="' + data[0][index] + '" /> <button type="submit" class="btn btn-link" onclick="return confirmDelete()"><i class="dripicons-trash"></i> {{trans("file.delete")}}</button></li><input type="hidden" class="hideACid" value="' + data[7][index] +'">{{ Form::close() }}</ul></div></td>'
                newRow.append(cols);
                newBody.append(newRow);
                $("table.deposit-list").append(newBody);
            });
            $("#view-deposit").modal('show');
        });
  });

  $("table.deposit-list").on("click", ".edit-btn", function(event) {
        var id = $(this).data('id');
        var rowindex = $(this).closest('tr').index();
        var date = $('table.deposit-list tbody tr:nth-child(' + (rowindex + 1) + ')').find('td:nth-child(1)').text();
        var amount = $('table.deposit-list tbody tr:nth-child(' + (rowindex + 1) + ')').find('td:nth-child(2)').text();
        var account_id = $(".hideACid").val();
        var note = $('table.deposit-list tbody tr:nth-child(' + (rowindex + 1) + ')').find('td:nth-child(4)').text();
        if(note == 'N/A')
            note = '';

        $('#edit-deposit input[name="deposit_id"]').val(id);
        $('#edit-deposit input[name="amount"]').val(amount);
        $('#edit-deposit input[name="deposit_date"]').val(date);
        $('#edit-deposit select[name="account_id"]').val(account_id).change();
        $('#edit-deposit textarea[name="note"]').val(note);
        $('#view-deposit').modal('hide');
    });

    var table = $('#customer-table').DataTable( {
        "order": [],
        'language': {
            'lengthMenu': '_MENU_ {{trans("file.records per page")}}',
             "info":      '<small>{{trans("file.Showing")}} _START_ - _END_ (_TOTAL_)</small>',
            "search":  '{{trans("file.Search")}}',
            'paginate': {
                    'previous': '<i class="dripicons-chevron-left"></i>',
                    'next': '<i class="dripicons-chevron-right"></i>'
            }
        },
        'columnDefs': [
            {
                "orderable": false,
                'targets': [0, 7]
            },
            {
                'render': function(data, type, row, meta){
                    if(type === 'display'){
                        data = '<div class="checkbox"><input type="checkbox" class="dt-checkboxes"><label></label></div>';
                    }

                   return data;
                },
                'checkboxes': {
                   'selectRow': true,
                   'selectAllRender': '<div class="checkbox"><input type="checkbox" class="dt-checkboxes"><label></label></div>'
                },
                'targets': [0]
            }
        ],
        'select': { style: 'multi',  selector: 'td:first-child'},
        'lengthMenu': [[10, 25, 50, -1], [10, 25, 50, "All"]],
        dom: '<"row"lfB>rtip',
        buttons: [
            {
                extend: 'pdf',
                text: '<i title="export to pdf" class="fa fa-file-pdf-o"></i>',
                exportOptions: {
                    columns: ':visible:Not(.not-exported)',
                    rows: ':visible'
                },
            },
            {
                extend: 'excel',
                text: '<i title="export to excel" class="dripicons-document-new"></i>',
                exportOptions: {
                    columns: ':visible:Not(.not-exported)',
                    rows: ':visible'
                },
            },
            {
                extend: 'csv',
                text: '<i title="export to csv" class="fa fa-file-text-o"></i>',
                exportOptions: {
                    columns: ':visible:Not(.not-exported)',
                    rows: ':visible'
                },
            },
            {
                extend: 'print',
                title: '',
                text: '<i title="print" class="fa fa-print"></i>',
                exportOptions: {
                    columns: ':visible:not(.not-exported)',
                    rows: ':visible',
                    stripHtml: false
                },
                repeatingHead: {
                    logo: logoUrl,
                    logoPosition: 'center',
                    logoStyle: '',
                    title: '<h1 class="text-center">Customer List</h1><hr>'
                },
            },
            {
                text: '<i title="delete" class="dripicons-cross"></i>',
                className: 'buttons-delete',
                action: function ( e, dt, node, config ) {
                    if(user_verified == '1') {
                        customer_id.length = 0;
                        $(':checkbox:checked').each(function(i){
                            if(i){
                                customer_id[i-1] = $(this).closest('tr').data('id');
                            }
                        });
                        if(customer_id.length && confirm("Are you sure want to delete?")) {
                            $.ajax({
                                type:'POST',
                                url:'customer/deletebyselection',
                                data:{
                                    customerIdArray: customer_id
                                },
                                success:function(data){
                                    alert(data);
                                }
                            });
                            dt.rows({ page: 'current', selected: true }).remove().draw(false);
                        }
                        else if(!customer_id.length)
                            alert('No customer is selected!');
                    }
                    else
                        alert('This feature is disable for demo!');
                }
            },
            {
                extend: 'colvis',
                text: '<i title="column visibility" class="fa fa-eye"></i>',
                columns: ':gt(0)'
            },
        ],
    } );

    function closeModal() {
        $('input[name="payment_date"]').val('').change();
    }

  if(all_permission.indexOf("customers-delete") == -1)
        $('.buttons-delete').addClass('d-none');
</script>
<script type="text/javascript" src="https://js.stripe.com/v3/"></script>
@endpush
