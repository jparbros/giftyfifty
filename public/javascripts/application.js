// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var loginBox, signinBox, loginLink, giftUrlText;

// Caching most used elements of the dom
var cacheElements = function() {
  loginSigninBox = $('div#login-signin-box');
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
  giftUrlText = giftInput.attr('value');
  birthdayInput = $('#user_birthday');
};

// Initializing boxes to login and sign in
var setBoxes = function() {
  loginSigninBox.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 350,
    width: 1000,
    modal: true,
  });
};

var giftInputChangeText = function() {
  giftInput.focusin(function(){
    $(this).attr('value','')
  });
  giftInput.focusout(function(){
    if($(this).attr('value') == '') {
      $(this).attr('value',giftUrlText)
    }
  });
}

var menuElements = function() {
  menuToggle = $('div#login div#menu_toggle');
  menuContent = $('div#login div#menu_content');
  menuElements = $('div#login div#menu_elements');
  loginBox = $('div#login');
  
}

var menuStyle = function() {
  width = menuToggle.width() + 20;
  menuElements.width(width)
  menuContent.width(width+20);
  if(menuContent.css('display') == 'block'){
    loginBox.css('background-color','')
  } else {
    loginBox.css('background','#292929') 
  }
}

var menuFunctionality = function() {
  menuElements();
  menuToggle.click(function(){
    menuStyle();
    menuContent.toggle();
  });
}

var getGiftUrl = function(){
  gift_url = giftInput.attr('value');
  loginGiftInputs.attr('value',gift_url);
  linksProviders.each(function(){
     _href = this.href;
      this.href = _href + '?gift_url=' + gift_url
  });
}

// Declaring the events
var declaringEvents = function() {
  loginLink.click(function() {
    getGiftUrl();
    loginSigninBox.dialog('open');
    return false;
  });
  buttonLogin.click(function() {
    getGiftUrl();
    loginSigninBox.dialog('open');
    return false;
  });
};

var setTimePickers = function() {
  startInput.datepicker({ minDate: 0,onSelect: function( selectedDate ) {
    var option = this.id == "event_start_at" ? "minDate" : "maxDate",
    instance = $( this ).data( "datepicker" );
    date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
    endInput.not( this ).datepicker( "option", option, date );
    }});
  endInput.datepicker({changeMonth: true});
  birthdayInput.datepicker({changeMonth: true,changeYear: true, minDate : new Date(1900, 1 - 1, 1)});
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
  giftInputChangeText();
  menuFunctionality();
});