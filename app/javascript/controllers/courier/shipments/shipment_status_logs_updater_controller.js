import { Controller } from 'stimulus';

export default class extends Controller {
  initialize(){
    this.path = this.data.get('path')
    this.targetStatusLogs = document.querySelector(this.data.get('inputStatusSelector'))
    this.targetNotes = document.querySelector(this.data.get('inputNotesSelector'))
  }

  connect(){
    this.bindClick();
  }

  bindClick(){
    $(this.element).on('click',this.handleClick.bind(this))
  }

  handleClick(e){
    const shipment_status_logs = {
      status: this.targetStatusLogs.value,
      notes: this.targetNotes.value,
    }
    window.Ajax.post(this.path,{
      data: JSON.stringify(shipment_status_logs),
      onSuccess: this.handleSuccess.bind(this),
      // onFail: this.handleFail.bind(this),
      // onDone: this.handleDone.bind(this)
      headers:[
        {
          key: 'X-CSRF-Token',
          value: window.Util.getCsrfToken()
        },
        {
          key: 'Content-Type',
          value: 'application/json'
        }
      ]
    })
  }

  handleSuccess(responseText){
    const parsedResponse = JSON.parse(responseText);
    var replaceTimeline = document.querySelector('.timeline-shipment-status-logs')
    var replaceDropdown = document.querySelector('.dropdown-shipment-status-updater')
    var replaceCurrentStatusLabel = document.querySelector('.label-current-shipment-status')
    
    replaceTimeline.innerHTML = parsedResponse.logs_html
    replaceDropdown.innerHTML = parsedResponse.dropdown_html
    replaceCurrentStatusLabel.innerText = parsedResponse.label_html
    this.targetNotes.value = ""
  }
}
