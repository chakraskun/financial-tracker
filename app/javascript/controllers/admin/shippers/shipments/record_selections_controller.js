import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [ 'counter' ];

  initialize(){
    this.selectedRecords = [];
  }

  connect(){
    this.element.addEventListener('record-selections:selected', this.handleRecordSelectionSelected.bind(this));
  }

  handleRecordSelectionSelected(e){
    const id = e.detail.id;
    const value = e.detail.value;
    this.decideRemovalOrAddition(id, value);
    this.decideShowCollapse();
    this.updateCounter();
    this.updateInHTML();
  }

  decideRemovalOrAddition(id, value){
    if(!value){
      this.removeFromSelectedRecordsIfExist(id)
      return;
    }
    this.addToSelectedRecordsIfNotExist(id);
  }

  removeFromSelectedRecordsIfExist(id){
    for(let i=0; i<this.selectedRecords.length; i++){
      if (this.selectedRecords[i] !== id) {
        continue;
      }
      this.selectedRecords.splice(i, 1);
      i--;
    }
  }

  addToSelectedRecordsIfNotExist(id){
    if(this.selectedRecords.includes(id)){
      return;
    }
    this.selectedRecords.push(id);
  }

  decideShowCollapse(){
    if(this.selectedRecords.length == 0){
      this.element.classList.remove('show');
      return;
    }
    this.element.classList.add('show');
  }

  updateCounter(){
    this.counterTarget.innerHTML = this.selectedRecords.length;
  }

  updateInHTML(){
    this.element.dataset.selectedRecords = this.selectedRecords.join(',');
  }
}
