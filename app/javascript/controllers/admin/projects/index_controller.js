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
        field: 'name',
        title: 'Name',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.name}</span>`;
        }
      },
      {
        field: 'description',
        title: 'Description',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.description}</span>`;
        }
      },
      {
        field: 'date',
        title: 'Date',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.date}</span>`;
        }
      },
      {
        field: 'due_date',
        title: 'Due Date',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.due_date}</span>`;
        }
      },
      {
        field: 'price',
        title: 'Price',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.price}</span>`;
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
              <a href="${data.show_path}" class="btn btn-sm btn-light-info btn-icon mr-1 mb-1" data-controller="tooltip" data-title="Show">
                <i class="far fa-eye icon-md"></i>
              </a>
              <a href="${data.delete_path}" class="btn btn-sm btn-light-danger btn-icon" data-controller="tooltip" data-title="Delete" data-method="delete" data-confirm="Are you sure you want to delete this?">
                <i class="fas fa-trash-alt icon-md"></i>
              </a>
            </div>
          `;
        },
      }
    ]
  }
}
