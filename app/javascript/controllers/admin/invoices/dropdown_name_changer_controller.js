import { Controller } from 'stimulus';

export default class extends Controller {
  initialize() {
    this.path = this.data.get('path')
    this.nameList = {};
    this.dropdownNameList = document.querySelector('.js-dropdown-name')
  }

  handleChangeInput(e) {
    let radio = e.srcElement
    if (!radio.checked) {
      return;
    }

    let invoiceType = e.target.value
    this.changeDropdownList(invoiceType);
  }

  changeDropdownList(invoiceType){
    window.KTApp.block(this.dropdownNameList,{
      overlayColor: 'red',
      opacity: 0.1,
      state: 'info'
    });
    const path = this.path.replace('-1', invoiceType);
    window.Ajax.get(path, {
      onSuccess: this.handleSuccess.bind(this),
      onFail: this.handleFail.bind(this),
      onDone: this.handleDone.bind(this)
    });
  }

  handleSuccess(responseText) {
    const parsedResponse = JSON.parse(responseText);
    this.dropdownNameList.innerHTML = parsedResponse.dropdown_html
  }

  handleFail(responseText) {
    console.log('[ERROR][SHIPMENT][AJAX_DROPDOWN_NAME]', responseText);
  }

  handleDone(responseText) {
    window.KTApp.unblock(this.dropdownNameList);
  }
}
