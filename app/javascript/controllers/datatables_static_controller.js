import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    if ( $(this.element).DataTable.isDataTable( this.element ) ) {
      return
    }

    if(this.element.classList.contains("dataTable")){
      return 
    }

    $(this.element).DataTable(
      {
        "iDisplayLength": 5,
        "paging": true,
        "ordering": true,
        "bInfo" : false ,
        "bLengthChange" : false,
        "scrollX": true,
        "bInfo" : false,
        "autoWidth": true,
        "responsive" : true,
        "searching": false,
        "dom": '<"row"<"col-md-12"ifl>>rt<"row"<"col-12 d-flex justify-content-end"p>><"clear">'
      }
    )
  }
}
