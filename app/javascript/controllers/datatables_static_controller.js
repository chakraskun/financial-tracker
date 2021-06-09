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
        "iDisplayLength": 10,
        "paging": true,
        "ordering": true,
        "bInfo" : false ,
        "bLengthChange" : false,
        "scrollX": true,
        "autoWidth": false,
        "bInfo" : false,
        "responsive" : true,
        "dom": '<"row"<"col-md-12"ifl>>rt<"row"<"col-md-2 mx-auto"p>><"clear">'
      }
    )
  }
}
