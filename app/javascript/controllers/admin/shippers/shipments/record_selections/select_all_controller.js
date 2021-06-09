import { Controller } from 'stimulus';

export default class extends Controller {
  change(e){
    this.inputElements.forEach((inputElement) => {
      inputElement.checked = this.element.checked;

      const event = new Event('change');
      inputElement.dispatchEvent(event);
    });
  }

  get inputElements(){
    return document.querySelectorAll('input[data-target="admin--shippers--shipments--record-selections--select-all.input"]');
  }
}
