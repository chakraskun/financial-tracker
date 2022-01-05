import DatatablesController from '../../datatables_controller';

export default class extends DatatablesController {
  connect(){
    super.connect();
  }

  datatableColumns(){
    return [
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
              <a href="${data.show_path}" class="btn btn-sm btn-light-info btn-icon mr-1 mb-1">
                <i class="far fa-eye icon-md"></i>
              </a>
              <a href="${data.edit_path}" class="btn btn-sm btn-light-primary btn-icon mr-1 mb-1">
                <i class="fas fa-pencil-alt"></i>
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
