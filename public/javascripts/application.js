// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var loginBox, signinBox, loginLink;

// Caching most used elements of the dom
var cacheElements = function() {
  loginBox = $('div#login-box');
  loginLink = $('a#login-link');
  buttonLogin = $('input#go-sign-in');
  buttonSearch = $('input#search-gift');
  startInput = $('input#event_start_at');
  endInput = $('input#event_end_at');
  giftInput = $('input#gift_url')
  loginGiftInputs = $('#new_user #gift_url')
  linksProviders = $('#login-box #providers a')
};

// Initializing boxes to login and sign in
var setBoxes = function() {
  loginBox.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 300,
    width: 950,
    modal: true,
  });
};

var getGiftUrl = function(){
  gift_url = giftInput.attr('value');
  loginGiftInputs.attr('value',gift_url);
  linksProviders.each(function(){
     _href = this.href;
      this.href = _href + '&gift_url=' + gift_url
  });
}

// Declaring the events
var declaringEvents = function() {
  loginLink.click(function() {
    getGiftUrl();
    loginBox.dialog('open');
    return false;
  });
  buttonLogin.click(function() {
    getGiftUrl();
    loginBox.dialog('open');
    return false;
  });
};

var setTimePickers = function() {
  startInput.datepicker({ minDate: 0});
  endInput.datepicker({ minDate: +5});
}

$(document).ready(function() {
  cacheElements();
  setBoxes();
  declaringEvents();
  setTimePickers();
});