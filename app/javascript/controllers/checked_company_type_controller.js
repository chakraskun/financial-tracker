import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    $(this.element).on('change', this.handleChangeChecked.bind(this));
  }

  handleChangeChecked(){
    let input_value = this.element.value
    if(this.element.checked){
      if (input_value == 'company'){
        document.querySelector(".select2").classList.remove("d-none")
        return
      }

      if (input_value == 'personal'){
        document.querySelector(".select2").classList.add("d-none")
        return
      }

      if (input_value == 'company_type'){
        document.querySelector(".js-input-consignee-company").classList.remove("d-none")
        return
      }

      if (input_value == 'personal_type'){
        document.querySelector(".js-input-consignee-company").classList.add("d-none")
        return
      }

      if (input_value == 'yes'){
        document.querySelector(".js-input-insurance-company").classList.remove("d-none")
        return
      }

      if (input_value == 'no'){
        document.querySelector(".js-input-insurance-company").classList.add("d-none")
        return
      }
    }
  }
}
