@extends('backend.layout.main') @section('content')
@if(session()->has('not_permitted'))
  <div class="alert alert-danger alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{{ session()->get('not_permitted') }}</div>
@endif
@if(session()->has('message'))
  <div class="alert alert-success alert-dismissible text-center"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>{!! session()->get('message') !!}</div>
@endif
<section>
    <div class="container-fluid">
        @if(in_array("suppliers-add", $all_permission))
        <a href="{{route('supplier.create')}}" class="btn btn-info"><i class="dripicons-plus"></i> {{trans('file.Add Supplier')}}</a>
        <a href="#" data-toggle="modal" data-target="#importSupplier" class="btn btn-primary"><i class="dripicons-copy"></i> {{trans('file.Import Supplier')}}</a>
        @endif
    </div>
    <div class="table-responsive">
        <table id="supplier-table" class="table supplierList">
            <thead>
                <tr>
                    <th class="not-exported"></th>
                    <th>{{trans('file.Image')}}</th>
                    <th>{{trans('file.Supplier Details')}}</th>
                    <th>{{trans('file.Total Due')}}</th>
                    <th class="not-exported">{{trans('file.action')}}</th>
                </tr>
            </thead>
            <tbody>
                @foreach($lims_supplier_all as $key => $supplier)
                <?php
                    $returned_amount = DB::table('purchases')
                                    ->join('return_purchases', 'purchases.id', '=', 'return_purchases.purchase_id')
                                    ->where([
                                        ['purchases.supplier_id', $supplier->id],
                                        ['purchases.payment_status', 1]
                                    ])
                                    ->sum('return_purchases.grand_total');
                    $purchaseData = App\Purchase::where([
                                    ['supplier_id', $supplier->id],
                                    ['payment_status', 1]
                                ])
                                ->selectRaw('SUM(total_cost) as total_cost,SUM(order_discount) as order_discount,SUM(grand_total) as grand_total,SUM(paid_amount) as paid_amount')
                                ->first();
                ?>
                <tr data-id="{{$supplier->id}}">
                    <td>{{$key}}</td>
                    @if($supplier->image)
                    <td> <img src="{{url('public/images/supplier',$supplier->image)}}" height="80" width="80">
                    </td>
                    @else
                    <td><img src="{{url('public/images/product/zummXD2dvAtI.png')}}" height="80" width="80"></td>
                    @endif
                    <td>
                        {{$supplier->name}}
                        <br>{{$supplier->company_name}}
                        @if($supplier->vat_number)
                        <br>{{$supplier->vat_number}}
                        @endif
                        <br>{{$supplier->email}}
                        <br>{{$supplier->phone_number}}
                        <br>{{$supplier->address}}, {{$supplier->city}}
                            @if($supplier->state){{','.$supplier->state}}@endif
                            @if($supplier->postal_code){{','.$supplier->postal_code}}@endif
                            @if($supplier->country){{','.$supplier->country}}@endif
                    </td>
                    <td>{{number_format(($purchaseData->total_cost - $purchaseData->order_discount) - $returned_amount - $purchaseData->paid_amount, 2)}}</td>
                    <td>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{{trans('file.action')}}
                                <span class="caret"></span>
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <ul class="dropdown-menu edit-options dropdown-menu-right dropdown-default" user="menu">
                                @if(in_array("suppliers-edit", $all_permission))
                                <li>
                                	<a href="{{ route('supplier.edit', $supplier->id) }}" class="btn btn-link"><i class="dripicons-document-edit"></i> {{trans('file.edit')}}</a>
                                </li>
                                @endif
                                @if(in_array("supplier-due-report", $all_permission))
                                <li>
                                    {!! Form::open(['route' => 'report.supplierDueByDate', 'method' => 'post', 'id' => 'supplier-due-report-form']) !!}
                                    <input type="hidden" name="start_date" value="{{date('Y-m-d', strtotime('-30 year'))}}" />
                                    <input type="hidden" name="end_date" value="{{date('Y-m-d')}}" />
                                    <input type="hidden" name="supplier_id" value="{{$supplier->id}}" />
                                    <button type="submit" class="btn btn-link"><i class="dripicons-pulse"></i> {{trans('file.Supplier Due Report')}}</button>
                                    {!! Form::close() !!}
                                </li>
                                @endif
                                <li>
                                    <button type="button" data-id="{{$supplier->id}}" class="clear-due btn btn-link" data-toggle="modal" data-target="#clearDueModal" ><i class="dripicons-brush"></i> {{trans('file.Clear Due')}}</button>
                                </li>
                                <li>
                                    <button type="button" data-id="{{$supplier->id}}" class="supplier-view-payment btn btn-link" data-toggle="modal" data-target="#supplierViewPayment" ><i class="fa fa-eye"></i> {{trans('file.View Payment')}}</button>
                                </li>
                                <li class="divider"></li>
                                @if(in_array("suppliers-delete", $all_permission))
                                {{ Form::open(['route' => ['supplier.destroy', $supplier->id], 'method' => 'DELETE'] ) }}
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

<div id="supplierViewPayment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="exampleModalLabel" class="modal-title">{{trans('file.All Payment')}}</h5>
                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
            </div>
            <div class="modal-body">
                <table class="table table-hover supplier-payment-list">
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
                </table>
            </div>
        </div>
    </div>
</div>

<div id="clearDueModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
    <div role="document" class="modal-dialog">
        <div class="modal-content">
            {!! Form::open(['route' => 'supplier.clearDue', 'method' => 'post', 'class' => 'payment-form']) !!}
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
                            <input type="hidden" name="supplier_id">
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

<div id="importSupplier" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
	<div role="document" class="modal-dialog">
	  <div class="modal-content">
	  	{!! Form::open(['route' => 'supplier.import', 'method' => 'post', 'files' => true]) !!}
	    <div class="modal-header">
	      <h5 id="exampleModalLabel" class="modal-title">{{trans('file.Import Supplier')}}</h5>
	      <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true"><i class="dripicons-cross"></i></span></button>
	    </div>
	    <div class="modal-body">
	      <p class="italic"><small>{{trans('file.The field labels marked with * are required input fields')}}.</small></p>
	       <p>{{trans('file.The correct column order is')}} (name*, image, company_name*, vat_number, email*, phone_number*, address*, city*,state, postal_code, country) {{trans('file.and you must follow this')}}.</p>
           <p>{{trans('file.To display Image it must be stored in')}} public/images/supplier {{trans('file.directory')}}</p>
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
                        <a href="public/sample_file/sample_supplier.csv" class="btn btn-info btn-block btn-md"><i class="dripicons-download"></i> {{trans('file.Download')}}</a>
                    </div>
                </div>
            </div>
	        <input type="submit" value="{{trans('file.submit')}}" class="btn btn-primary" id="submit-button">
		</div>
		{!! Form::close() !!}
	  </div>
	</div>
</div>

@endsection

@push('scripts')
<script type="text/javascript">

    $("ul#people").siblings('a').attr('aria-expanded','true');
    $("ul#people").addClass("show");
    $("ul#people #supplier-list-menu").addClass("active");

    var public_key = <?php echo json_encode($lims_pos_setting_data->stripe_public_key) ?>;
    var all_permission = <?php echo json_encode($all_permission) ?>;
    var supplier_id = [];
    var user_verified = <?php echo json_encode(env('USER_VERIFIED')) ?>;
    var logoUrl = <?php echo json_encode(url('public/logo', $general_setting->site_logo)) ?>;

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $(".supplier-view-payment").on("click", function () {
        var id = $(this).data('id').toString();
        $.get('suppliers/getpayment/' + id, function(data) {
            // console.log(data)
            $(".supplier-payment-list tbody").remove();
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

            $.each(payment_date, function(index){
                var newRow = $("<tr>");
                var cols = '';

                cols += '<td>' + payment_date[index] + '</td>';
                /*cols += '<td>' + payment_reference[index] + '</td>';*/
                cols += '<td>' + account_name[index] + '</td>';
                cols += '<td>' + paid_amount[index] + '</td>';
                cols += '<td>' + paying_method[index] + '</td>';

                newRow.append(cols);
                newBody.append(newRow);
                $("table.supplier-payment-list").append(newBody);
            });
            $('#supplierViewPayment').modal('show');
        });
    });

    $(".clear-due").on("click", function() {
        var id = $(this).data('id').toString();
        $("#clearDueModal input[name='supplier_id']").val(id);
        $("#cheque").hide();
        $(".card-element").hide();
        rowindex = $(this).closest('tr').index();
        $('select[name="paid_by_id"]').val(1);
        var balance = $('table.supplierList tbody tr:nth-child(' + (rowindex + 1) + ')').find('td:nth-child(4)').text();
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

	function confirmDelete() {
	    if (confirm("Are you sure want to delete?")) {
	        return true;
	    }
	    return false;
	}

    $('#supplier-table').DataTable( {
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
                'targets': [0, 1, 2, 3]
            },
            {
                'checkboxes': {
                   'selectRow': true
                },
                'targets': 0
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
                    rows: ':visible',
                    stripHtml: false
                },
                customize: function(doc) {
                    for (var i = 1; i < doc.content[1].table.body.length; i++) {
                        if (doc.content[1].table.body[i][0].text.indexOf('<img src=') !== -1) {
                            var imagehtml = doc.content[1].table.body[i][0].text;
                            var regex = /<img.*?src=['"](.*?)['"]/;
                            var src = regex.exec(imagehtml)[1];
                            var tempImage = new Image();
                            tempImage.src = src;
                            var canvas = document.createElement("canvas");
                            canvas.width = tempImage.width;
                            canvas.height = tempImage.height;
                            var ctx = canvas.getContext("2d");
                            ctx.drawImage(tempImage, 0, 0);
                            var imagedata = canvas.toDataURL("image/png");
                            delete doc.content[1].table.body[i][0].text;
                            doc.content[1].table.body[i][0].image = imagedata;
                            doc.content[1].table.body[i][0].fit = [30, 30];
                        }
                    }
                },
            },
            {
                extend: 'excel',
                text: '<i title="export to excel" class="dripicons-document-new"></i>',
                exportOptions: {
                    columns: ':visible:Not(.not-exported)',
                    rows: ':visible',
                    format: {
                        body: function ( data, row, column, node ) {
                            if (column === 0 && (data.indexOf('<img src=') !== -1)) {
                                var regex = /<img.*?src=['"](.*?)['"]/;
                                data = regex.exec(data)[1];
                            }
                            return data;
                        }
                    }
                },
            },
            {
                extend: 'csv',
                text: '<i title="export to csv" class="fa fa-file-text-o"></i>',
                exportOptions: {
                    columns: ':visible:Not(.not-exported)',
                    rows: ':visible',
                    format: {
                        body: function ( data, row, column, node ) {
                            if (column === 0 && (data.indexOf('<img src=') !== -1)) {
                                var regex = /<img.*?src=['"](.*?)['"]/;
                                data = regex.exec(data)[1];
                            }
                            return data;
                        }
                    }
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
                    title: '<h1 class="text-center">Supplier List</h1><hr>'
                },
            },
            {
                text: '<i title="delete" class="dripicons-cross"></i>',
                className: 'buttons-delete',
                action: function ( e, dt, node, config ) {
                    if(user_verified == '1') {
                        supplier_id.length = 0;
                        $(':checkbox:checked').each(function(i){
                            if(i){
                                supplier_id[i-1] = $(this).closest('tr').data('id');
                            }
                        });
                        if(supplier_id.length && confirm("Are you sure want to delete?")) {
                            $.ajax({
                                type:'POST',
                                url:'supplier/deletebyselection',
                                data:{
                                    supplierIdArray: supplier_id
                                },
                                success:function(data){
                                    alert(data);
                                }
                            });
                            dt.rows({ page: 'current', selected: true }).remove().draw(false);
                        }
                        else if(!supplier_id.length)
                            alert('No supplier is selected!');
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

    if(all_permission.indexOf("suppliers-delete") == -1)
        $('.buttons-delete').addClass('d-none');

</script>
<script type="text/javascript" src="https://js.stripe.com/v3/"></script>
@endpush
