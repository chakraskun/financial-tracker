import DatatablesController from '../../datatables_controller';

export default class extends DatatablesController {
  connect(){
    super.connect();
    // this.bindChangeFilterShipper();
    // this.bindChangeFilterDestination();
    // this.bindChangeDateFilter();
  }

  // bindChangeDateFilter(){
  //   $('#kt_dashboard_daterangepicker_custom').on('apply.daterangepicker', function(ev, picker) {
  //     const startDate = picker.startDate.format('DD/MM/YYYY')
  //     const endDate = picker.endDate.format('DD/MM/YYYY')
  //     this.datatable.search(`${startDate} - ${endDate}`, "daterange")
  //   }.bind(this));
  // }

  // bindChangeFilterShipper(){
  //   const element = $('#kt_datatable_search_shipper_name');
  //   element.on('change', () => {
  //     this.datatable.search(element.val().toLowerCase(), "shipper_id")
  //   })
  // }

  // bindChangeFilterDestination(){
  //   const element = $('#kt_datatable_search_destination_type');
  //   element.on('change', () => {
  //     this.datatable.search(element.val().toLowerCase(), "destination_type");
  //   })
  // }

  datatableColumns(){
    return [
      {
        field: 'index',
        title: 'No.',
        width: 50,
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.index}</span>`;
        }
      },
      {
        field: 'name',
        title: 'Name',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.name}</span>`;
        }
      },
      {
        field: 'created_at',
        title: 'Created At',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.created_at}</span>`;
        }
      }
    ]
  }
}
