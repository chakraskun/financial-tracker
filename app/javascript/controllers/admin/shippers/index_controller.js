import DatatablesController from '../../datatables_controller';

export default class extends DatatablesController {
  datatableColumns(){
    return [
      {
        field: 'index',
        title: '#',
        sortable: false,
        width: 40,
        type: 'number',
        selector: false,
        textAlign: 'left',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.index}</span>`;
        }
      },
      {
        field: 'shipper_type',
        title: 'Shipper Type',
        autoHide: false,
        template: function(data) {
          return `<span class="font-weight-bolder">${data.shipper_type}</span>`;
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
        field: 'total_credit',
        title: 'Total Credit',
        autoHide: false,
        template: function(data) {
          if(data.shipper_type == 'Personal'){
            return `<span class="font-weight-bolder"> - </span>`;
          }
          if(data.shipper_type == 'Company'){
            return `<span class="font-weight-bolder">${data.total_credit}</span>`;
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
            <a href="${data.show_path}" class="btn btn-sm btn-light-info btn-icon" title="Show Detail">
              <i class="fa fa-eye icon-md"></i>
            </a>
            <a href="${data.edit_path}" class="btn btn-sm btn-light-primary btn-icon" title="Edit Shipper">
              <i class="fas fa-pencil-alt icon-md"></i>
            </a>
            <a href="${data.delete_path}" class="btn btn-sm btn-light-danger btn-icon" title="Delete Shipper" data-method="delete" data-confirm="Are you sure you want to delete this?">
              <i class="fas fa-trash-alt icon-md"></i>
            </a>
          `;
        }
      }
    ]
  }
}
