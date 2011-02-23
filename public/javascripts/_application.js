// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var loginBox, signinBox, loginLink, giftUrlText;

// Caching most used elements of the dom
var cacheElements = function() {
  loginLink = $('a#login-link');
  siginLink = $('a#sigin-link');
  buttonLogin = $('input#go-sign-in');
  buttonSearch = $('input#search-gift');
  
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
  siginLink.click(function(){
    mainLoginBox();
    return false;
  });
  loginLink.click(function(){
    mainLoginBox();
    return false;
  });
  buttonLogin.click(function(){
    mainLoginBox();
    return false;
  });
};

var mainLoginBox = function() {
  $.fancybox({
    'titlePosition' : 'inside',
    'transitionIn' : 'none',
    'transitionOut' : 'none',
    'width' : '1100',
    'height' : '350',
    'autoScale' : false,
    'autoDimensions' : false,
    'content': $('#fancybox-content').html(),
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
  menuToggle = $('div#login div#user-menu');
  menuContent = $('div#login ul#menu-content');
  menuElements = $('#menu-content li');
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

var friendSelector = function() {
  $('div.friend').live('click',function(){
    checkbox = $(this).find('input[type=checkbox]')
    if(checkbox.attr('checked')) {
      $(this).removeClass('selected');
      checkbox.attr('checked', false);
    } else {
      $(this).addClass('selected');
      checkbox.attr('checked', true);
    }
  });
};

$(document).ready(function() {
  cacheElements();
  setBoxes();
  setTimePickers();
  giftInputChangeText();
  menuFunctionality();
  loadingAjax();
  birthdayInput.datepicker({changeMonth: true,changeYear: true, yearRange : '1970:2011'});
});