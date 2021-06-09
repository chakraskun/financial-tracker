import DatatablesController from '../../datatables_controller';

export default class extends DatatablesController {
  connect(){
    super.connect();
    this.bindChangeFilterPaymentStatus();
    this.bindChangeFilterDestination();
    this.bindChangeDateFilter();
  }

  bindChangeDateFilter(){
    $('#kt_dashboard_daterangepicker_custom').on('apply.daterangepicker', function(ev, picker) {
      const startDate = picker.startDate.format('DD/MM/YYYY')
      const endDate = picker.endDate.format('DD/MM/YYYY')
      this.datatable.search(`${startDate} - ${endDate}`, "daterange")
    }.bind(this));
  }

  bindChangeFilterPaymentStatus(){
    const element = $('#kt_datatable_search_payment_status');
    element.on('change', () => {
      this.datatable.search(element.val().toLowerCase(), "payment_status")
    })
  }

  bindChangeFilterDestination(){
    const element = $('#kt_datatable_search_destination_type');
    element.on('change', () => {
      this.datatable.search(element.val().toLowerCase(), "destination_type");
    })
  }
  
  datatableColumns(){
    return [
      {
        field: 'checkbox',
        title: `
          <label class="checkbox checkbox-single checkbox-all">
            <input
              type="checkbox"
              data-controller="admin--shippers--shipments--record-selections--select-all"
              data-action="change->admin--shippers--shipments--record-selections--select-all#change"
            >&nbsp;
            <span></span>
          </label>
        `,
        sortable: false,
        width: 40,
        selector: false,
        textAlign: 'left',
        autoHide: false,
        template: function(data) {
          return `
            <label class="checkbox checkbox-single">
              <input
                type="checkbox"
                name="selected_user_id"
                value="${data.id}"
                data-controller="admin--shippers--shipments--record-selections--records"
                data-target="admin--shippers--shipments--record-selections--select-all.input"
              >
              &nbsp;
              <span></span>
            </label>`;
        }
      },
      {
        field: 'index',
        title: '#',
        autoHide: false,
        width: 10,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.index}</span>`;
        }
      },
      {
        field: 'date',
        title: 'Date',
        autoHide: false,
        width: 90,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.date}</span>`;
        }
      },
      {
        field: 'awb',
        title: 'WB',
        autoHide: false,
        width: 90,
        sortable: false,
        template: function(data) {
          if(data.shipment_destination_type == "international"){
            return `<span class="font-weight-bolder">${data.awb}</span><br>
            <span class="text-success font-weight-bolder">[INT]</span>`;
          }
          if(data.shipment_destination_type == "domestic"){
            return `<span class="font-weight-bolder">${data.awb}</span><br>
            <span class="text-success font-weight-bolder">[DOM]</span>`;
          }
        }
      },
      {
        field: 'consignee_name',
        title: 'Consignee',
        autoHide: false,
        width: 100,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.consignee_name}</span>`;
        }
      },
      {
        field: 'consignee_address',
        title: 'Dest',
        sortable: false,
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.consignee_address}</span>`;
        }
      },
      {
        field: 'item_name',
        title: 'Item<br>[Qty][Weight]',
        autoHide: false,
        width: 110,
        sortable: false,
        template: function(data) {
        return `<span class="font-weight-bolder">${data.item_name}</span>
        <br><span class="text-success font-weight-bolder">[${data.item_quantity}][${data.item_weight} kg(s)]</span>`;
        }
      },
      {
        field: 'shipment_price',
        title: 'Price',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.shipment_price}</span>`;
        }
      },
      {
        field: 'cr_type',
        title: 'Cr Type',
        autoHide: false,
        width: 50,
        sortable: false,
        template: function(data) {
          if(data.shipment_type == "reguler" && data.shipment_payment == "cash"){
            return `<span class="font-weight-bolder">REG</span>`;
          }
          if(data.shipment_type == "one_day_service" && data.shipment_payment == "cash"){
            return `<span class="font-weight-bolder">ODS</span>`;
          }
          if(data.shipment_type == "reguler" && data.shipment_payment == "credit"){
            return `<span class="font-weight-bolder">Cr REG</span>`;
          }
          if(data.shipment_type == "one_day_service" && data.shipment_payment == "credit"){
            return `<span class="font-weight-bolder">Cr ODS</span>`;
          }
        }
      },
      {
        field: 'payment_status',
        title: 'Status',
        autoHide: false,
        width: 70,
        template: function(data) {
          if(data.payment_status == "paid"){
            return `<span class="label label-inline label-lg label-success btn-sm font-weight-bolder">PAID</span>`;
          }
          if(data.payment_status == "unpaid"){
            return `<span class="label label-inline label-lg label-danger btn-sm font-weight-bolder">UNPAID</span>`;
          }
        }
      },
    ]
  }
}
