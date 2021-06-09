import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    $(this.element).select2({
      tags: true,
      width: '100%',
      matcher: function(params, data) {
        let original_matcher = $.fn.select2.defaults.defaults.matcher;
        let result = original_matcher(params, data);
        if (
          result &&
          data.children &&
          result.children &&
          data.children.length != result.children.length &&
          data.text.toLowerCase().includes(params.term)
        ){
          result.children = data.children;
        }
        return result;
      },
      placeholder: '== Choose =='
    });

  }
}
