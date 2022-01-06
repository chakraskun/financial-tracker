import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    if(this.element.dataset.connected){
      return;
    }

    this.element.id = window.Util.uuidv4();
    this.element.dataset.connected = '1';
  }
}
