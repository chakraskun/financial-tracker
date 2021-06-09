import DatatablesController from '../../datatables_controller';

export default class extends DatatablesController {
  connect(){
    super.connect();
  }

  datatableColumns(){
    return [
      {
        field: 'index',
        title: '#',
        width: 15,
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bold">${data.index}</span>`;
        }
      },
      {
        field: 'wb',
        title: 'WB',
        autoHide: false,
        sortable: false,
        template: function(data) {
          if(data.shipment_type == "one_day_service"){
            return `<a href="${data.show_path}" class="text-dark font-weight-bolder">${data.wb}
            <br><span class="text-success font-weight-bolder">[ODS]</span></a>
            `;
          }
          if(data.shipment_type == "reguler"){
            return `<a href="${data.show_path}" class="text-dark font-weight-bolder">${data.wb}
            <br><span class="text-success font-weight-bolder">[REG]</span></a>
            `;
          }
        }
      },
      {
        field: 'consignee_name',
        title: 'Consignee',
        autoHide: false,
        sortable: false,
        template: function(data) {
          return `<a href="${data.show_path}" class="text-danger font-weight-bolder">${data.consignee_name}</class><br>
          <span class="text-dark font-weight-light">${data.consignee_address}</span></a>`;
        }
      },
      {
        field: 'status',
        title: 'Status',
        autoHide: false,
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
      }
    ]
  }
}
