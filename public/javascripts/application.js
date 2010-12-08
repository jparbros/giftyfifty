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
  giftInput = $('input#gift_url');
  loginGiftInputs = $('#new_user #gift_url');
  linksProviders = $('#login-box #providers a');
  tabsContent = $("#tabs");
  giftButtonNext = $('#gift-button');
  eventButtonNext = $('#event-button');
};

// Initializing boxes to login and sign in
var setBoxes = function() {
  loginBox.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 350,
    width: 1000,
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

var setTabs = function() {
  tabsContent.tabs();
}

var buttonsCreateEvent = function(){
  giftButtonNext.click(function(){
    tabsContent.tabs({ selected: 1 });
  });
  eventButtonNext.click(function(){
    tabsContent.tabs({ selected: 2 });
  });
}

$(document).ready(function() {
  cacheElements();
  setBoxes();
  declaringEvents();
  setTimePickers();
});