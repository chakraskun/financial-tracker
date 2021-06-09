import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    this.element.addEventListener('change', this.handleChange.bind(this));
  }

  handleChange(e){
    const srcElement = e.srcElement;
    this.triggerEvent(srcElement.value, srcElement.checked);
  }

  triggerEvent(id, value){
    const event = new CustomEvent('record-selections:selected', {
      detail: {
        id: id,
        value: value
      }
    });
    this.recordSelectionsContainer.dispatchEvent(event);
  }

  get recordSelectionsContainer(){
    return document.querySelector('[data-controller="admin--shippers--shipments--record-selections"]');
  }
}
