import { Controller } from 'stimulus';

export default class extends Controller {
  submit(e){
    e.preventDefault();
    this.constructAndAppendParamsHTML();
    this.element.submit();
  }

  constructAndAppendParamsHTML(){
    const tempParams = this.selectedUserId.map((userId) => {
      return `<input type="hidden" name="selected_user_id[]" value="${userId}">`;
    });
    const paramsHTML = tempParams.join('');
    this.element.insertAdjacentHTML('afterbegin', paramsHTML);
  }

  get selectedUserId(){
    return this.recordSelectionContainer.dataset.selectedRecords.split(',');
  }

  get recordSelectionContainer(){
    return document.querySelector('[data-controller="admin--shippers--shipments--record-selections"]');
  }
}
