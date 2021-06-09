import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    $(this.element).datetimepicker({
      format: 'LT'
    });
  }
}
