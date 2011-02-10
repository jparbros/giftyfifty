// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var loginBox, signinBox, loginLink, giftUrlText;

// Caching most used elements of the dom
var cacheElements = function() {
  loginLink = $('a#login-link');
  siginLink = $('a#sigin-link');
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

var setTimePickers = function() {
  startInput.datepicker({ minDate: 0,onSelect: function( selectedDate ) {
    var option = this.id == "event_start_at" ? "minDate" : "maxDate",
    instance = $( this ).data( "datepicker" );
    date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
    date.setTime(date.getTime()+5*24*60*60*1000)
    _minDate = $.datepicker.formatDate($.datepicker._defaults.dateFormat, date);
    date.setTime(date.getTime()+50*24*60*60*1000)
    _maxDate = $.datepicker.formatDate($.datepicker._defaults.dateFormat, date);
    endInput.datepicker( "destroy" );
    endInput.datepicker({changeMonth: true, minDate : _minDate, maxDate : _maxDate });
    }});
  birthdayInput.datepicker({changeMonth: true,changeYear: true, yearRange : '1970:2011'});
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

var validateEventEditForm = function() {
  $('#gift-form').validate({
      rules: {
          'event[title]': 'required',
          'event[start_at]': 'required',
          'event[end_at]': 'required'
      },
      messages: {
          'event[title]': 'The title is required.',
          'event[start_at]': 'The start date is required.',
          'event[end_at]': 'The end date is required.',
      }
  });
}

var qtipsEditEvent = function() {
  $('#event_occasion_id').qtip({
    content: 'Select your special occasion.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true }
  });
  $('#event_title').qtip({
    content: 'Enter a creative title for your special occasion.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true }
  });
  $('#gift_description').qtip({
    content: 'Create a description to your friends,let them know exactly why you\'ll love to receive this gift!',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true }
  });
  $('#event_start_at').qtip({
    content: 'From this date, your friends can start making donations.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true }
  });
  $('#event_end_at').qtip({
    content: 'Until this date, your friends can making donations.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true }
  });
};

var qtipsShowEvent = function() {
  $('#edit_event').qtip({
    content: 'Edit your gift\'s details.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true }
  });
  $('#release-gift').qtip({
    content: 'Do the checkout to get your gift.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true }
  });
  $('#gift_percentage').qtip({
    content: 'This represent the percent you\'ve collected of your gift\'s cost.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
  $('#event_rest_days').qtip({
    content: 'This is the your friend\'s limit time to donate to your celebration\'s gift.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
  $('#gift_donors').qtip({
    content: 'They\'re your friends that have donated you!',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
  $('.share-on').qtip({
    content: 'Use your social networks or email and let your friends know about your special occasion.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
  $('#event_url').qtip({
    content: 'This is your unique URL, copy and share it everywhere you like!',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
};

var qtipsShowEventVisitor = function() {
  $('#gift_percentage').qtip({
    content: 'This represent the percent collected of the gift\'s cost.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
  $('#event_rest_days').qtip({
    content: 'This is the limit time to donate to celebration\'s gift.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
  $('#gift_donors').qtip({
    content: 'They\'re friends that have donated!',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
  $('.share-on').qtip({
    content: 'Use social networks or email and let your friends know about this special occasion.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
  $('#event_url').qtip({
    content: 'This is the unique URL, copy and share it everywhere you like!',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topLeft' } }
  });
};

var qtipsEditSettings = function() {
  $('#upload_avatar img').qtip({
    content: 'Your avatar is the picture we\'ll display on your profile.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topMiddle' } }
  });
  $('#upload_username').qtip({
    content: 'Choose a unique username, it\'s important to give you a personilized URL.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topMiddle' } }
  });
  $('#delete_account').qtip({
    content: 'This permanently delete your account, you won\'t be able to retrieve your information once you confirm it.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topMiddle' } }
  });
}

var qtipsMyAccount = function() {
  $('a.view_event').qtip({
    content: 'See your active event, donations and friends comments.',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topRight' } }
  });
  $('div.share-on').qtip({
    content: 'Post on facebook or tweet for invite your friends to join Gifty Fifty and donate you!',
    style: { name: 'dark', border: { width: 0,radius: 4 }, tip: true },
    position: { corner: { tooltip: 'bottomRight', target: 'topRight' } }
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

var loadingAjax = function() {
  $("img#ajax-loader").bind("ajaxSend", function(){
     $(this).show();
   }).bind("ajaxComplete", function(){
     $(this).hide();
  });
}

var donationCheckbox = function() {
  $(':radio').change(function(){
    if($(this).attr('value')==='credit_card') {
      $('div#credit_card').show();
      $('div#paypal').hide();
    }
    if($(this).attr('value')==='paypal') {
      $('div#credit_card').hide();
      $('div#paypal').show();
    }
  });
}

var acceptTerms = function() {
  $('input#terms, #donation_amount, #donation_name, #donation_credit_card, #donation_verification_value, #payment_method_credit_card, #payment_method_paypal').change(function(){
    if( ($('input#terms').attr('checked') === true)  && ($('#donation_amount').val() != '') && ($('#donation_amount').val() != ' ')) {
      if($('#payment_method_credit_card').attr('checked') == true) {
        if(($('#donation_name').attr('value') != '') && ($('#donation_credit_card').attr('value') != '') && ($('#donation_verification_value').attr('value') != '')) {
          $('input#save').removeAttr('disabled').removeClass('disable');
        } else {
          $('input#save').attr('disabled','disabled').addClass('disable');
        }
      } else {
        $('input#save').removeAttr('disabled').removeClass('disable');
      }
    } else {
      $('input#save').attr('disabled','disabled').addClass('disable');
    }
  });
}

var onlyNumber = function() {
  $("#donation_amount").keypress(function (e)
  {
    if( e.which!=8 && e.which!=0 && (e.which<48 || e.which>57))
    {
      return false;
    }
  });
}

var calculateFeed = function() {
  $('#donation_amount').change(function(){
    donation = $('#donation_amount').attr('value') * 100;
    payment_fee = (donation * 0.0229) + 30;
    our_fee = (donation * 0.05);
    total_fee = (payment_fee + our_fee)/100;
    donation = (donation/100.00)-total_fee;
    $('#direct').html('$' + donation.toFixed(2));
    $('#handing').html('$' + total_fee.toFixed(2))
  });
}

$(document).ready(function() {
  cacheElements();
  setBoxes();
  setTimePickers();
  giftInputChangeText();
  menuFunctionality();
  loadingAjax();
});