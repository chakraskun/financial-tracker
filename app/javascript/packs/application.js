// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'controllers'

import Util from './lib/util';
window.Util = Util;

import Ajax from './lib/ajax';
window.Ajax = Ajax;

import Flash from './lib/flash';
window.Flash = Flash;

window.addEventListener('beforeinstallprompt', (e) => {
  // Stash the event so it can be triggered later.
  const lastPrompt = window.localStorage.getItem('mtu-beforeinstallprompt-last-prompt');
  if(!lastPrompt){
    e.prompt();
    e.userChoice
      .then((choiceResult) => {
        if (choiceResult.outcome === 'accepted') {
          console.log('User accepted the A2HS prompt');
        } else {
          console.log('User dismissed the A2HS prompt');
        }

        // this.deferredPrompt = null;
        // window.deferredPrompt = null;
      });

    const current = new Date();
    window.localStorage.setItem('mtu-beforeinstallprompt-last-prompt', current.getTime().toString());
  } else {
    const current = new Date();
    const last = new Date(parseInt(lastPrompt));
    var diff = Math.abs(current.getTime() - last.getTime()) / 3600000;
    if (diff < 1) {
      return;
    }

    e.prompt();
    e.userChoice
      .then((choiceResult) => {
        if (choiceResult.outcome === 'accepted') {
          console.log('User accepted the A2HS prompt');
        } else {
          console.log('User dismissed the A2HS prompt');
        }

        // this.deferredPrompt = null;
        // window.deferredPrompt = null;
      });
    window.localStorage.setItem('mtu-beforeinstallprompt-last-prompt', current.getTime().toString());
  }
});
window.addEventListener('load', () => {
  navigator.serviceWorker.register('/service-worker.js').then(registration => {
    console.log('ServiceWorker registered: ', registration);

    var serviceWorker;
    if (registration.installing) {
      serviceWorker = registration.installing;
      console.log('Service worker installing.');
    } else if (registration.waiting) {
      serviceWorker = registration.waiting;
      console.log('Service worker installed & waiting.');
    } else if (registration.active) {
      serviceWorker = registration.active;
      console.log('Service worker active.');
    }
  }).catch(registrationError => {
    console.log('Service worker registration failed: ', registrationError);
  });
});
