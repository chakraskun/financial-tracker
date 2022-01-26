import { Controller } from 'stimulus';

export default class extends Controller {
  initialize(){
    this.incomeCard = document.querySelector('#addModal')
    this.nominal = this.incomeCard.querySelectorAll(".js-nominal")
    this.nominalChecker = this.incomeCard.querySelector(".js-nominal-checker-value-idr")
    this.submitButton = this.incomeCard.querySelector(".js-submit-button")
  }

  connect(){
    $(this.nominal).on('change', this.handleCalculateTotal.bind(this));
    $(this.nominalChecker).on('change', this.handleCalculateTotal.bind(this));
  }

  handleCalculateTotal(){
    this.nominal = this.incomeCard.querySelectorAll(".js-nominal")
    var totalLines = 0
    for (var i = 0; i < this.nominal.length; i++) {
      let nominal = parseFloat(this.incomeCard.querySelector(`input[name="monthly_plan_lines[${i}][price]"]`).value.replace(/[.Rp ]/g, ''))
      totalLines += nominal
    }
    this.handleComparisonPrice(totalLines);
  }

  handleComparisonPrice(totalLines){
    let comparisonValueIdr = parseFloat(this.nominalChecker.value.replace(/[.Rp ]/g, ''))
    if(comparisonValueIdr == totalLines){
      this.submitButton.disabled = false
      this.submitButton.classList.remove('btn-danger')
      this.submitButton.classList.add('btn-success')
      $('.js-submit-button').popover('dispose')
    } else {
      this.submitButton.disabled = true
      this.submitButton.classList.remove('btn-success')
      this.submitButton.classList.add('btn-danger')
    }
  }

  handleRemove(){
    this.handleCalculateTotal();
  }

  formatInput(total){
    if(total.toString().includes(".")){
      return window.Util.addThousandSeparator(total.toString().replace(".",","))
    }else{
      return window.Util.addThousandSeparator(total.toString().replace(".",",")) + ",00"
    }
  }
}
