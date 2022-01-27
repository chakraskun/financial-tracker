import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    $(this.element).on('click', this.handleShowModal.bind(this));
  }

  handleShowModal(e){
    e.preventDefault();
    let modal_id = this.element.dataset.target;
    $(modal_id).modal('show');
  }
}
