import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    this.element.innerHTML = window.Util.addThousandSeparator(parseInt(this.element.innerHTML));
  }
}
