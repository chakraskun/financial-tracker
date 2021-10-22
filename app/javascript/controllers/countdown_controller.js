import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    this.timer = document.querySelector('.js-countdown')
  }

  initialize(){
    var timer = document.querySelector('.js-countdown')
    var countDownDate = new Date("Dec 11, 2021 8:00:00").getTime();
    var x = setInterval(function() {

      var now = new Date().getTime();
      var distance = countDownDate - now;
      var days = Math.floor(distance / (1000 * 60 * 60 * 24));
      var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((distance % (1000 * 60)) / 1000);
      
      timer.innerHTML = days + " Days, " + hours + " Hours, " + minutes + " Minutes ";
        
      if (distance < 0) {
        clearInterval(x);
        timer.innerHTML = "EXPIRED";
      }
    }, 1000);
  }
}
