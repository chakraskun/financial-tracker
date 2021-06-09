import { Controller } from 'stimulus';

export default class extends Controller {
  initialize(){
    this.modalElement = this.element.parentElement.parentElement.parentElement.parentElement
    
    this.path = this.data.get('path');
    this.email = this.modalElement.querySelector("#shipper_email") 
    this.address = this.modalElement.querySelector("#shipper_address") 
    this.zip_code = this.modalElement.querySelector("#shipper_zip_code") 
    this.origin = this.modalElement.querySelector("#shipper_origin") 
    this.phone_number = this.modalElement.querySelector("#shipper_phone_number") 
  }

  connect(){
    this.bindChange();
  }

  bindChange(){
    $(this.element).on('select2:select', this.handleChange.bind(this))
  }

  handleChange(e){
    const path = this.path.replace('-1', e.params.data.id);
    window.KTApp.blockPage();
    window.Ajax.get(path, {
      onSuccess: this.handleSuccess.bind(this),
      onFail: this.handleFail.bind(this),
      onDone: this.handleDone.bind(this)
    });
  }

  handleSuccess(responseText){
    const parsedResponse = JSON.parse(responseText);

    this.email.value = parsedResponse.email;
    this.email.disabled = true;

    this.address.value = parsedResponse.address;
    this.address.disabled = true;

    this.zip_code.value = parsedResponse.zip_code;
    this.zip_code.disabled = true;
    
    this.origin.value = parsedResponse.origin;
    this.origin.disabled = true;
    
    this.phone_number.value = parsedResponse.phone_number;
    this.phone_number.disabled = true;
  }

  handleFail(responseText){
    console.log('[ERROR][ADMIN][SHIPMENT#GET_SHIPPER_INFO]', responseText);
  }

  handleDone(responseText){
    window.KTApp.unblockPage();
  }
}
