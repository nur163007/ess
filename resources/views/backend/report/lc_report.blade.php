@extends('backend.layout.main') @section('content')
    <section class="forms">
        <div class="container-fluid">
            <div class="card">
                <div class="card-header mt-2">
                    <h3 class="text-center">{{trans('file.LC Report')}}</h3>
                </div>
                {!! Form::open(['route' => 'report.lc', 'method' => 'post']) !!}
                <div class="row mb-3">
                    <div class="col-md-4 offset-md-2 mt-3">
                        <div class="form-group row">
                            <label class="d-tc mt-2"><strong>{{trans('file.Choose Your Date')}}</strong> &nbsp;</label>
                            <div class="d-tc">
                                <div class="input-group">
                                    <input type="text" class="daterangepicker-field form-control" value="{{$start_date}} To {{$end_date}}" required />
                                    <input type="hidden" name="start_date" value="{{$start_date}}" />
                                    <input type="hidden" name="end_date" value="{{$end_date}}" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mt-3">
                        <div class="form-group row">
                            <label class="d-tc mt-2"><strong>{{trans('file.Choose LC No')}}</strong> &nbsp;</label>
                            <div class="d-tc">
                                <input type="hidden" name="lcno_hidden" value="{{$lcno}}" />
                                <select id="lc_num" name="lc_no" class="selectpicker form-control" data-live-search="true" data-live-search-style="begins">
                                    @foreach($lims_lcno_list as $lcno)
                                        <option value="{{$lcno->lc_no}}">{{$lcno->lc_no}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2 mt-3">
                        <div class="form-group">
                            <button class="btn btn-primary" type="submit">{{trans('file.submit')}}</button>
                        </div>
                    </div>
                </div>
{{--                <input type="hidden" name="user_id_hidden" value="{{$user_id}}" />--}}
                {!! Form::close() !!}
            </div>
        </div>
        <ul class="nav nav-tabs ml-4 mt-3" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" href="#user-purchase" role="tab" data-toggle="tab">{{trans('file.Purchase')}}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#user-transfer" role="tab" data-toggle="tab">{{trans('file.Transfer')}}</a>
            </li>
        </ul>

        <div class="tab-content">

            <div role="tabpanel" class="tab-pane fade show active" id="user-purchase">
                <div class="table-responsive mb-4">
                    <table id="purchase-table" class="table table-hover">
                        <thead>
                        <tr>
                            <th class="not-exported-purchase"></th>
                            <th>{{trans('file.Date')}}</th>
                            <th>{{trans('file.Lighter particular')}}</th>
                            <th>{{trans('file.Warehouse')}}</th>
                            <th>{{trans('file.product')}} ({{trans('file.qty')}})</th>
                            <th>{{trans('file.Status')}}</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($lims_purchase_data as $key=>$purchase)
                            <?php
                            $shipping_data = $lims_purchase_data[$key]['shipping'];
                            $shipType = [];
                            ?>
                            @if($shipping_data)
                                @foreach($shipping_data as $key=>$ship_summary)
                                    <?php
                                    $shipType = $ship_summary->shipping_type;
                                    ?>
                                @endforeach
                             @endif
                            <tr>
                                <td>{{$key}}</td>
                                <td>{{date($general_setting->date_format, strtotime($purchase->created_at->toDateString())) . ' '. $purchase->created_at->toTimeString()}}</td>
                                @if($shipType == 1)
                                    <td>Truck</td>
                                @elseif($shipType == 2)
                                    <td>Lighter</td>
                                @else
                                    <td>Mother vassel</td>
                                @endif
                                <td>{{$purchase->warehouse->name}}</td>
                                <td>
                                    @foreach($lims_product_purchase_data[$key] as $product_purchase_data)
                                        <?php
                                        $product = App\Product::select('name')->find($product_purchase_data->product_id);
                                        if($product_purchase_data->variant_id) {
                                            $variant = App\Variant::find($product_purchase_data->variant_id);
                                            $product->name .= ' ['.$variant->name.']';
                                        }
                                        $unit = App\Unit::find($product_purchase_data->purchase_unit_id);
                                        ?>
                                        @if($unit)
                                            {{$product->name.' ('.$product_purchase_data->qty.' '.$unit->unit_name.')'}}
                                        @else
                                            {{$product->name.' ('.$product_purchase_data->qty.')'}}
                                        @endif
                                        <br>
                                    @endforeach
                                </td>
                                @if($purchase->status == 1)
                                    <td><div class="badge badge-success">{{trans('file.Recieved')}}</div></td>
                                @elseif($purchase->status == 2)
                                    <td><div class="badge badge-success">{{trans('file.Partial')}}</div></td>
                                @elseif($purchase->status == 3)
                                    <td><div class="badge badge-danger">{{trans('file.Pending')}}</div></td>
                                @elseif($purchase->status == 4)
                                    <td><div class="badge badge-danger">{{trans('file.Ordered')}}</div></td>
                                @endif
                            </tr>
                        @endforeach
                        </tbody>
                        <tfoot class="tfoot active">
                        <tr>
                            <th></th>
                            <th></th>
                            <th>Total:</th>
                            <th></th>
                            <th>0.00</th>
                            <th></th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <div role="tabpanel" class="tab-pane fade" id="user-transfer">
                <div class="table-responsive mb-4">
                    <table id="transfer-table" class="table table-hover">
                        <thead>
                        <tr>
                            <th class="not-exported-transfer"></th>
                            <th>{{trans('file.Date')}}</th>
                            <th>{{trans('file.Lighter particular')}}</th>
                            <th>{{trans('file.From')}}</th>
                            <th>To {{trans('file.Warehouse')}}</th>
                            <th>{{trans('file.product')}}</th>
                            <th>{{trans('file.Total')}} ({{trans('file.qty')}})</th>
                            <th>{{trans('file.Transfer')}} ({{trans('file.qty')}})</th>
                            <th>{{trans('file.Remaining')}} ({{trans('file.qty')}})</th>
                            <th>{{trans('file.Status')}}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $total_qty =0;
                        ?>
                        @foreach($lims_product_transfer_data as $key=>$product_transfer)
                            <?php
                                    $total_qty +=$product_transfer->qty;
                                    $product = App\Product::select('name')->find($product_transfer->product_id);
                                    if($product_transfer->variant_id) {
                                        $variant = App\Variant::find($product_transfer->variant_id);
                                        $product->name .= ' ['.$variant->name.']';
                                    }
                                    $unit = App\Unit::find($product_transfer->purchase_unit_id);
                            ?>
                            <tr>
                                <td>{{$key}}</td>
                                <td>{{date($general_setting->date_format, strtotime($product_transfer->created_at->toDateString())) . ' '. $product_transfer->created_at->toTimeString()}}</td>
                                @if($product_transfer->shipping_type == 1)
                                    <td>Truck</td>
                                @elseif($product_transfer->shipping_type == 2)
                                    <td>Lighter</td>
                                @else
                                    <td>Mother vassel</td>
                                @endif
                                <td>{{$product_transfer->fromWarehouse}}</td>
                                <td>{{$product_transfer->toWarehouse}}</td>
                                <td>{{$product->name}}</td>
                                <td>
                                    {{$product_transfer->total_qty}}

                                </td>
                                <td>
                                   {{$product_transfer->qty}}
                                </td>
                                <td>
                                   {{$product_transfer->total_qty - $total_qty}}

                                </td>
                                @if($product_transfer->status == 1)
                                    <td><div class="badge badge-success">{{trans('file.Completed')}}</div></td>
                                @elseif($product_transfer->status == 2)
                                    <td><div class="badge badge-danger">{{trans('file.Pending')}}</div></td>
                                @else
                                    <td><div class="badge badge-warning">{{trans('file.Sent')}}</div></td>
                                @endif
                            </tr>
                        @endforeach
                        </tbody>
                        <tfoot class="tfoot active">
                        <tr>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th>Total:</th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th>0.00</th>
                            <th></th>
                            <th></th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div>
    </section>


@endsection

@push('scripts')
    <script type="text/javascript">
        $("ul#report").siblings('a').attr('aria-expanded','true');
        $("ul#report").addClass("show");
        $("ul#report #lc-report-menu").addClass("active");

        var logoUrl = <?php echo json_encode(url('public/logo', $general_setting->site_logo)) ?>;
        var lcNo = $('input[name="lcno_hidden"]').val();
        $('select[name="lc_no"]').val($('input[name="lcno_hidden"]').val()).change();
        $('.selectpicker').selectpicker('refresh');


        $('#purchase-table').DataTable( {
            "order": [],
            'columnDefs': [
                {
                    "orderable": false,
                    'targets': 0
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
                    exportOptions: {
                        columns: ':visible:Not(.not-exported-purchase)',
                        rows: ':visible'
                    },
                    action: function(e, dt, button, config) {
                        datatable_sum_purchase(dt, true);
                        $.fn.dataTable.ext.buttons.pdfHtml5.action.call(this, e, dt, button, config);
                        datatable_sum_purchase(dt, false);
                    },
                    footer:true
                },
                {
                    extend: 'excel',
                    exportOptions: {
                        columns: ':visible:Not(.not-exported-purchase)',
                        rows: ':visible'
                    },
                    action: function(e, dt, button, config) {
                        datatable_sum_purchase(dt, true);
                        $.fn.dataTable.ext.buttons.excelHtml5.action.call(this, e, dt, button, config);
                        datatable_sum_purchase(dt, false);
                    },
                    footer:true
                },
                {
                    extend: 'csv',
                    exportOptions: {
                        columns: ':visible:Not(.not-exported-purchase)',
                        rows: ':visible'
                    },
                    action: function(e, dt, button, config) {
                        datatable_sum_purchase(dt, true);
                        $.fn.dataTable.ext.buttons.csvHtml5.action.call(this, e, dt, button, config);
                        datatable_sum_purchase(dt, false);
                    },
                    footer:true
                },
                {
                    extend: 'print',
                    title: '',
                    text: '<i title="print" class="fa fa-print"></i>',
                    exportOptions: {
                        columns: ':visible:not(.not-exported-purchase)',
                        rows: ':visible',
                        stripHtml: false
                    },
                    repeatingHead: {
                        logo: logoUrl,
                        logoPosition: 'center',
                        logoStyle: '',
                        title: '<h1 class="text-left">LC purchase report</h1>' +
                                '<h3 class="text-left">LC No : '+lcNo+'</h3>'
                    },
                    action: function(e, dt, button, config) {
                        datatable_sum_purchase(dt, true);
                        $.fn.dataTable.ext.buttons.print.action.call(this, e, dt, button, config);
                        datatable_sum_purchase(dt, false);
                    },
                    footer:true
                },
                {
                    extend: 'colvis',
                    columns: ':gt(0)'
                }
            ],
            drawCallback: function () {
                var api = this.api();
                datatable_sum_purchase(api, false);
            }
        } );

        function datatable_sum_purchase(dt_selector, is_calling_first) {
            if (dt_selector.rows( '.selected' ).any() && is_calling_first) {
                var rows = dt_selector.rows( '.selected' ).indexes();

                $( dt_selector.column( 4 ).footer() ).html(dt_selector.cells( rows, 4, { page: 'current' } ).data().sum().toFixed(2));
           }
            else {
                $( dt_selector.column( 4 ).footer() ).html(dt_selector.column( 4, {page:'current'} ).data().sum().toFixed(2));
                }
        }


        $('#transfer-table').DataTable( {
            "order": [],
            'columnDefs': [
                {
                    "orderable": false,
                    'targets': 0
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
                    exportOptions: {
                        columns: ':visible:Not(.not-exported-transfer)',
                        rows: ':visible'
                    },
                    action: function(e, dt, button, config) {
                        datatable_sum_transfer(dt, true);
                        $.fn.dataTable.ext.buttons.pdfHtml5.action.call(this, e, dt, button, config);
                        datatable_sum_transfer(dt, false);
                    },
                    footer:true
                },
                {
                    extend: 'excel',
                    exportOptions: {
                        columns: ':visible:Not(.not-exported-transfer)',
                        rows: ':visible'
                    },
                    action: function(e, dt, button, config) {
                        datatable_sum_transfer(dt, true);
                        $.fn.dataTable.ext.buttons.excelHtml5.action.call(this, e, dt, button, config);
                        datatable_sum_transfer(dt, false);
                    },
                    footer:true
                },
                {
                    extend: 'csv',
                    exportOptions: {
                        columns: ':visible:Not(.not-exported-transfer)',
                        rows: ':visible'
                    },
                    action: function(e, dt, button, config) {
                        datatable_sum_transfer(dt, true);
                        $.fn.dataTable.ext.buttons.csvHtml5.action.call(this, e, dt, button, config);
                        datatable_sum_transfer(dt, false);
                    },
                    footer:true
                },
                {
                    extend: 'print',
                    title: '',
                    text: '<i title="print" class="fa fa-print"></i>',
                    exportOptions: {
                        columns: ':visible:not(.not-exported-transfer)',
                        rows: ':visible',
                        stripHtml: false
                    },
                    repeatingHead: {
                        logo: logoUrl,
                        logoPosition: 'center',
                        logoStyle: '',
                        title: '<h1 class="text-left">LC transfer report</h1>' +
                            '<h3 class="text-left">LC No : '+lcNo+'</h3>'
                    },
                    action: function(e, dt, button, config) {
                        datatable_sum_transfer(dt, true);
                        $.fn.dataTable.ext.buttons.print.action.call(this, e, dt, button, config);
                        datatable_sum_transfer(dt, false);
                    },
                    footer:true
                },
                {
                    extend: 'colvis',
                    columns: ':gt(0)'
                }
            ],
            drawCallback: function () {
                var api = this.api();
                datatable_sum_transfer(api, false);
            }
        } );

        function datatable_sum_transfer(dt_selector, is_calling_first) {
            if (dt_selector.rows( '.selected' ).any() && is_calling_first) {
                var rows = dt_selector.rows( '.selected' ).indexes();

                // $( dt_selector.column( 5 ).footer() ).html(dt_selector.cells( rows, 5, { page: 'current' } ).data().sum().toFixed(2));
                $( dt_selector.column( 7 ).footer() ).html(dt_selector.cells( rows, 7, { page: 'current' } ).data().sum().toFixed(2));
            }
            else {

                // $( dt_selector.column( 5 ).footer() ).html(dt_selector.column( 5, {page:'current'} ).data().sum().toFixed(2));
                $( dt_selector.column( 7 ).footer() ).html(dt_selector.column( 7, {page:'current'} ).data().sum().toFixed(2));
            }
        }


        $(".daterangepicker-field").daterangepicker({
            callback: function(startDate, endDate, period){
                var start_date = startDate.format('YYYY-MM-DD');
                var end_date = endDate.format('YYYY-MM-DD');
                var title = start_date + ' To ' + end_date;
                $(this).val(title);
                $('input[name="start_date"]').val(start_date);
                $('input[name="end_date"]').val(end_date);
            }
        });

    </script>
@endpush
