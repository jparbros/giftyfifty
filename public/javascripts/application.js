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
    height: 400,
    width: 1000,
    modal: true,
  });
};

var loadFacebook = function() {
   window.fbAsyncInit = function() {
      FB.init({appId: '175826409094308', status: true, cookie: true,
               xfbml: true});
    };
    $(function() {
      var e = document.createElement('script'); e.async = true;
      e.src = document.location.protocol +
        '//connect.facebook.net/en_US/all.js';
      document.getElementById('fb-root').appendChild(e);
    }());
}

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

var loadShareObjects = function() {
  twitterBox = $('div#share-twitter');
  facebookBox = $('div#share-facebook');
  emailBox = $('div#share-email');
  twitterButton = $('div.share-on a#twitter-share-link');
  facebookButton = $('div.share-on a#facebook-share-link');
  emailButton = $('div.share-on a#email-share-link');
  twitterTextarea = $('div#share-twitter textarea');
  twitterCounter = $('div.ui-dialog span#twitter_counter');
}

var dialogShareBoxes = function() {
  twitterBox.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 350,
    width: 350,
    modal: true,
  });
  facebookBox.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 350,
    width: 350,
    modal: true,
  });
  emailBox.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 350,
    width: 350,
    modal: true,
  });
  twitterButton.click(function(){
    twitterBox.dialog('open');
    return false;
  });
  facebookButton.click(function(){
    facebookBox.dialog('open');
    return false;
  });
  emailButton.click(function(){
    emailBox.dialog('open');
    return false;
  });
}

var emailSharing = function() {
  addEmail = $('div.ui-dialog #add-new-email');
  emailsBox = $('div.ui-dialog #all_emails');
  emailInput = $('div.ui-dialog #add_email');
  addEmail.click(function(){
    createEmail(emailInput.attr('value'));
    return false;
  });
};

var createEmail = function(email_text) {
  new_box = $('<div>'+ email_text +'</div>');
  new_box.appendTo(emailsBox);
  $('<input type="hidden" />').attr('name', 'emails[]').attr('value',email_text).appendTo(new_box);
  close_button = $('<span>X</span>');
  close_button.appendTo(new_box);
  close_button.css({'cursor':'pointer'});
  emailInput.attr('value','');
  close_button.click(function(){
    $(this).parent().remove();
  });
};

var countCharacters = function() {
  twitterTextarea.counter({
    count: 'down', 
    goal: 140
  });
};

var releaseBox = function() {
  release = $('div#release-box');
  releaseButton = $('a#release-gift');
  release.dialog({
    resizable: false,
    stack: false,
    autoOpen: false,
    height: 150,
    width: 450,
    modal: true,
  });
  releaseButton.click(function(){
    release.dialog('open');
    return false;
  });
}

var validateUserEditForm = function() {
  $('#user_edit').validate({
      rules: {
          'user[first_name]': 'required',
          'user[last_name]': 'required',
          'user[birthday]': 'required',
          'user[username]': 'required'
      },
      messages: {
          'user[first_name]': 'The first name is required.',
          'user[last_name]': 'The last name is required.',
          'user[birthday]': 'The birthday is required.',
          'user[username]': 'The username is required.'
      }
  });
}

var remoteStatesFunction = function(action_url) {
  $('#user_address_attributes_country').change(function(){
    $.ajax({
      url: action_url,
      data: "country=" + $('#user_address_attributes_country').attr('value'),
      success: function(data) {
        $('#user_edit_states').html(data);
      }
    });
  })
}

$(document).ready(function() {
  cacheElements();
  setBoxes();
  declaringEvents();
  setTimePickers();
  giftInputChangeText();
  menuFunctionality();
});