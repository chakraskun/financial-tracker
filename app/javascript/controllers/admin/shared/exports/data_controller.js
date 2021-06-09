import { Controller } from 'stimulus';

export default class extends Controller {
  initialize(){
    if(this.data.get('inputSelectors')){
      this.constructInitialParam();
    }
    this.path = this.element.action;
  }
  constructInitialParam(){
    const tokens = this.data.get('inputSelectors').split(',');
    this.params = [];
    for(let i=0; i<tokens.length; i++){
      const pair = tokens[i].split(':');;
      const key = pair[0];
      const value = pair[1];
      this.params.push({
        name: value,
        element: document.querySelector(key)
      });
    }
  }

  submit(e){
    e.preventDefault();
    const params = this.queryParams();

    params.forEach((param) => {
      const currentElementParam = this.element.querySelector(
        `input[type="hidden"][name="${param.name}"]`
      );
      if(!currentElementParam){
        this.element.insertAdjacentHTML('afterbegin', `
          <input type="hidden" name="${param.name}" value="${param.value}">
        `);
        return;
      }
      currentElementParam.value = param.value;
    });

    this.element.submit();
  }

  queryParams(){
    let result = [];
    if(!this.params){
      return result;
    }

    for(let i=0; i<this.params.length; i++){
      const currentParam = this.params[i];
      const name = currentParam.name;

      if(!currentParam.element){
        continue;
      }

      if(currentParam.element.id === 'kt_dashboard_daterangepicker_custom'){
        const daterangepicker = $(currentParam.element).data('daterangepicker');
        const startDate = daterangepicker.startDate.format('DD/MM/YYYY');
        const endDate = daterangepicker.endDate.format('DD/MM/YYYY');
        const value = `${startDate} - ${endDate}`;
        result.push({
          name: name,
          value: value
        });
      }

      const value = currentParam.element.value;
      if(!value){
        continue;
      }

      if(currentParam.element.tagName === "SELECT"){
        if(currentParam.element.multiple){
          const selectedOptions = currentParam.element.selectedOptions;
          const values = [];
          for(let i=0; i<selectedOptions.length; i++){
            values.push(selectedOptions[i].value);
          }

          result.push({
            name: name,
            value: values.join(',')
          });
          continue;
        }
      }

      result.push({
        name: name,
        value: value
      });
    }

    return result;
  }
}
