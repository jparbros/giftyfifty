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

// Declaring the events
var declaringEvents = function() {
  loginLink.click(function() {
    loginBox.dialog('open');
    return false;
  });
  buttonLogin.click(function() {
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