import DatatablesController from '../../datatables_controller';

export default class extends DatatablesController {
  connect(){
    super.connect();
    this.bindChangeFilterShipper();
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

  bindChangeFilterShipper(){
    const element = $('#kt_datatable_search_shipper_name');
    element.on('change', () => {
      this.datatable.search(element.val().toLowerCase(), "shipper_id")
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
        field: 'date',
        title: 'Date',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.date}</span>`;
        }
      },
      {
        field: 'wb',
        title: 'WB',
        autoHide: false,
        width: 90,
        sortable: false,
        template: function(data) {
          if(data.shipment_destination_type == "international"){
            return `<span class="font-weight-bolder">${data.wb}</span>
            <br><span class="text-success font-weight-bolder">[INT]</span>
            `;
          }
          if(data.shipment_destination_type == "domestic"){
            return `<span class="font-weight-bolder">${data.wb}</span>
            <br><span class="text-success font-weight-bolder">[DOM]</span>
            `;
          }
        }
      },
      {
        field: 'shipper_name',
        title: 'Shipper<br>[Consignee]',
        autoHide: false,
        sortable: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.shipper_name}</span>
          <br><span class="text-success font-weight-bolder">[${data.consignee_name}]</span>`;
        }
      },
      {
        field: 'consignee_address',
        title: 'Dest',
        autoHide: false,
        sortable: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.consignee_address}</span>`;
        }
      },
      {
        field: 'item_name',
        title: 'Item<br>[Qty][Weight]',
        autoHide: false,
        sortable: false,
        template: function(data) {
          return `
            <span class="font-weight-bolder">${data.item_name}</span>
            <br><span class="text-success font-weight-bolder">[${data.item_quantity}][${data.item_weight} kg]</span>
          `;
        }
      },
      {
        field: 'shipment_price',
        title: 'Price<br>[Cr Type]',
        autoHide: false,
        sortable: false,
        template: function(data) {
          if(data.shipment_type == "reguler" && data.shipment_payment == "cash"){
            return `<span class="font-weight-bolder">${data.shipment_price}</span><br>
            <span class="text-success font-weight-bolder">[REG]</span>`;
          }
          if(data.shipment_type == "one_day_service" && data.shipment_payment == "cash"){
            return `<span class="font-weight-bolder">${data.shipment_price}</span><br>
            <span class="text-success font-weight-bolder">[ODS]</span>`;
          }
          if(data.shipment_type == "reguler" && data.shipment_payment == "credit"){
            return `<span class="font-weight-bolder">${data.shipment_price}</span><br>
            <span class="text-success font-weight-bolder">[Cr REG]</span>`;
          }
          if(data.shipment_type == "one_day_service" && data.shipment_payment == "credit"){
            return `<span class="font-weight-bolder">${data.shipment_price}</span><br>
            <span class="text-success font-weight-bolder">[Cr ODS]</span>`;
          }
        }
      },
      {
        field: 'status',
        title: 'Status',
        autoHide: false,
        width: 170,
        template: function(data) {
          if(data.status == "Received" || data.status == "Transhipment received"){
            return `
            <span class="font-weight-bold label label-inline label-lg label-warning btn-sm" style="color:black;background-color:#fadf7d;")">${data.status}</span><br>
            <span class="font-size-xs">${data.date_time_id}<br>
            ${data.notes}</span>`;
          }
          if(data.status == "Return to sender"){
            return `
            <span class="font-weight-bold label label-inline label-lg label-warning btn-sm" style="color:black;background-color:#b73719;")">${data.status}</span><br>
            <span class="font-size-xs">${data.date_time_id}<br>
            ${data.notes}</span>`;
          }
          else {
            return `
            <span class="font-weight-bold label label-inline label-lg label-outline-dark btn-sm">${data.status}</span><br>
            <span class="font-size-xs">${data.date_time_id}<br>
            ${data.notes}</span>`;
          }
        }
      },
      {
        field: 'Actions',
        title: 'Actions',
        sortable: false,
        overflow: 'visible',
        autoHide: false,
        template: function(data) {
          return `
            <div class="wrap" style="display:flex;flex-wrap:nowrap;">
              <a href="${data.show_path}" class="btn btn-sm btn-light-info btn-icon mr-1 mb-1">
                <i class="far fa-eye icon-md"></i>
              </a>
              <a href="#" class="btn btn-sm btn-light-primary btn-icon mr-1 mb-1">
                <i class="fas fa-edit icon-md"></i>
              </a>
              <a href="${data.delete_path}" class="btn btn-sm btn-light-danger btn-icon" data-method="delete" data-confirm="Are you sure you want to delete this?">
                <i class="fas fa-trash-alt icon-md"></i>
              </a>
            </div>
          `;
        },
      }
    ]
  }
}
