import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    $(this.element).datepicker({
      startView: "months", 
      minViewMode: "months",
      todayHighlight: true,
      format: 'MM yyyy',
      autoclose: true,
    });
  }
}
