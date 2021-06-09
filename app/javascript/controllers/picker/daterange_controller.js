import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    $(this.element).daterangepicker({
      buttonClasses: ' btn',
      applyClass: 'btn-primary',
      cancelClass: 'btn-secondary',
      autoclose: true,

      timePicker: true,
      timePickerIncrement: 30,
      locale: {
        format: 'DD/MM/YYYY HH:mm'
      }
    }, (start, end, label) => {
      $(this.element.querySelector('.form-control')).val( start.format('DD/MM/YYYY HH:mm') + ' - ' + end.format('DD/MM/YYYY HHH:mm'));
    });
  }
}
