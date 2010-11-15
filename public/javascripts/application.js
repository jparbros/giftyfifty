// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var loginBox, signinBox, loginLink;

// Caching most used elements of the dom
var cacheElements = function() {
  loginBox = $('div#login-box');
  signinBox = $("div#sign-in-box");
  loginLink = $('a#login-link');
  buttonLogin = $('input#go-sign-in');
  buttonSearch = $('input#search-gift');
};

// Initializing boxes to login and sign in
var setBoxes = function() {
  loginBox.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 215,
    width: 650,
    modal: true,
  });
  
  signinBox.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 305,
    width: 650,
    modal: true,
  });
};

// Declaring the events
var declaringEvents = function() {
  loginLink.click(function() {
    signinBox.dialog('close');
    loginBox.dialog('open');
    return false;
  });
  buttonLogin.click(function() {
    signinBox.dialog('open');
  });
};

$(document).ready(function() {
  cacheElements();
  setBoxes();
  declaringEvents();
});