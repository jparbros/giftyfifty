$.fn.extend({
  getGiftUrl: function(){
    this.click(function(){
      giftInput = $('input#gift_url');
      gift_url = giftInput.attr('value');
      if ($.validUrl(gift_url)) {
        if ( $(this).attr('id') === 'go-sign-in') {          
          loginGiftInputs = $('#new_user #gift_url');
          loginGiftInputs.attr('value',gift_url);
          $('#login-box #providers a').each(function(){
             _href = this.href;
              this.href = _href + '?gift_url=' + gift_url
          });
          $.loginFancybox();
          return false;
        }
      } else {
        $.jGrowl('Please, Insert a valid url.', { sticky: true });
        return false;
      }
    });
  }
});

$.extend({
  userVoice: function(){
    var uservoiceOptions = {
      /* required */
      key: 'giftyfifty',
      host: 'giftyfifty.uservoice.com', 
      forum: '92345',
      showTab: true,  
      /* optional */
      alignment: 'left',
      background_color:'#4CD3EC', 
      text_color: 'white',
      hover_color: '#28CAE8',
      lang: 'en'
    };

    function _loadUserVoice() {
      var s = document.createElement('script');
      s.setAttribute('type', 'text/javascript');
      s.setAttribute('src', ("https:" == document.location.protocol ? "https://" : "http://") + "cdn.uservoice.com/javascripts/widgets/tab.js");
      document.getElementsByTagName('head')[0].appendChild(s);
    }
    _loadSuper = window.onload;
    window.onload = (typeof window.onload != 'function') ? _loadUserVoice : function() { _loadSuper(); _loadUserVoice(); };
  },
  googleAnalitycs: function() {
    var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-20340029-1']);
      _gaq.push(['_setDomainName', '.giftyfifty.com']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
  },
  
  loginFancybox: function() {
    $.fancybox({
        'titlePosition' : 'inside',
        'transitionIn' : 'none',
        'transitionOut' : 'none',
        'width' : '1100',
        'height' : '350',
        'autoScale' : false,
        'autoDimensions' : false,
        'content': $('#box-content').html(),
    });
    $.validateSignup();
    $.validateLogin();
  },
  
  loginSigninBox: function() {
    $('a#sigin-link, a#login-link').click(function(){
      $.loginFancybox();
      return false;
    });
  },
  
  loadFacebook: function() {
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
  },
  
  giftInputChangeText: function() {
    var giftInput = $('input#gift_url');
    var giftUrlText = giftInput.attr('value');
    giftInput.focusin(function(){
      $(this).attr('value','')
    });
    giftInput.focusout(function(){
      if($(this).attr('value') == '') {
        $(this).attr('value',giftUrlText)
      }
    });
  },
  
  menuElements : function() {
    menuToggle = $('div#login-box div#user-menu');
    menuContent = $('div#login-box ul#menu-content');
    menuElements = $('#menu-content li');
    loginBox = $('div#login-box');
  },
  
  menuStyle: function() {
    width = menuToggle.width() + 20;
    menuElements.width(width)
    menuContent.width(width+20);
    if(menuContent.css('display') == 'block'){
      loginBox.css('background-color','')
    } else {
      loginBox.css('background','#292929') 
    }
  },
  
  menuFunctionality: function() {
    $.menuElements();
    menuToggle.click(function(){
      $.menuStyle();
      menuContent.toggle();
    });
  },
  
  giftInputChangeText: function() {
    giftInput = $('input#gift_url');
    giftUrlText = giftInput.attr('value');
    giftInput.focusin(function(){
      $(this).attr('value','')
    });
    giftInput.focusout(function(){
      if($(this).attr('value') == '') {
        $(this).attr('value',giftUrlText)
      }
    });
  },
  
  validUrl: function(inputValue){
    var url_pattern = new RegExp("((http|https)(:\/\/))?([a-zA-Z0-9]+[.]{1}){2}[a-zA-z0-9]+(\/{1}[a-zA-Z0-9]+)*\/?", "i");
    if(url_pattern.test(inputValue)) { 
      return true;
    } else {
      return false;
    }
  },
  validateSignup: function() {
    $('div#fancybox-content div#sign-in #user_submit').click(function(){
      $('div#fancybox-content div#sign-in input, div#fancybox-content div#sign-in input:password').removeClass('emptyField');
      inputs = $('div#fancybox-content div#sign-in input:text[value=""], div#fancybox-content div#sign-in input:password[value=""]');
      inputs.addClass('emptyField');
      if(inputs.size() > 0) {
        return false;
      }
    });
  },
  validateLogin: function() {
    $('div#fancybox-content div#login #user_submit').click(function(){
      $('div#fancybox-content div#login input, div#fancybox-content div#login input:password').removeClass('emptyField');
      inputs = $('div#fancybox-content div#login input:text[value=""], div#fancybox-content div#login input:password[value=""]');
      inputs.addClass('emptyField');
      if(inputs.size() > 0) {
        return false;
      }
    });
  },
  loadShareObjects: function() {
    twitterBox = $('div#share-twitter');
    facebookBox = $('div#share-facebook');
    emailBox = $('div#share-email');
    twitterButton = $('div.share-on a#twitter-share-link');
    facebookButton = $('div.share-on a#facebook-share-link');
    emailButton = $('div.share-on a#email-share-link');
    twitterTextarea = $('div#share-twitter textarea');
    twitterCounter = $('div.ui-dialog span#twitter_counter');
  },
  dialogShareBoxes: function() {
    twitterBox = $('div#share-twitter');
    facebookBox = $('div#share-facebook');
    emailBox = $('div#share-email');
    twitterButton = $('a#twitter-share-link');
    facebookButton = $('a#facebook-share-link');
    emailButton = $('a#email-share-link');
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
  },
  countCharacters : function() {
    twitterTextarea.counter({
      count: 'down', 
      goal: 140
    });
  },
  qtipsMyAccount: function() {
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
  },
  validateUserEditForm: function() {
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
  },
  remoteStatesFunction: function(action_url) {
    $('#user_address_attributes_country').change(function(){
      $.ajax({
        url: action_url,
        data: "country=" + $('#user_address_attributes_country').attr('value'),
        success: function(data) {
          $('#user_edit_states').html(data);
        }
      });
    })
  },
  qtipsEditSettings: function() {
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
  },
  validateEventEditForm: function() {
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
  },
  qtipsEditEvent: function() {
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
  },
  setTimePickers: function() {
    startInput = $('input#event_start_at');
    endInput = $('input#event_end_at');
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
  },
  releaseBox: function() {
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
  },
  qtipsShowEvent: function() {
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
  },
  qtipsShowEventVisitor: function() {
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
  },
  emailSharing: function() {
    addEmail = $('div.ui-dialog #add-new-email');
    emailsBox = $('div.ui-dialog #all_emails');
    emailInput = $('div.ui-dialog #add_email');
    addEmail.click(function(){
      $.createEmail(emailInput.attr('value'));
      return false;
    });
  },
  createEmail: function(email_text) {
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
  },
  donationCheckbox: function() {
    $(':radio').change(function(){
      if($(this).attr('value')==='credit_card') {
        $('div#credit-card').show();
        $('div#paypal').hide();
      }
      if($(this).attr('value')==='paypal') {
        $('div#credit-card').hide();
        $('div#paypal').show();
      }
    });
  },
  acceptTerms: function() {
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
  },
  onlyNumber: function() {
    $("#donation_amount").keypress(function (e)
    {
      if( e.which!=8 && e.which!=0 && (e.which<48 || e.which>57))
      {
        return false;
      }
    });
  },
  calculateFeed: function() {
    $('#donation_amount').change(function(){
      donation = $('#donation_amount').attr('value') * 100;
      payment_fee = (donation * 0.0229) + 30;
      our_fee = (donation * 0.05);
      total_fee = (payment_fee + our_fee)/100;
      donation = (donation/100.00)-total_fee;
      $('#direct').html('$' + donation.toFixed(2));
      $('#handing').html('$' + total_fee.toFixed(2))
    });
  },
  loadingAjax: function() {
    $("img#ajax-loader").bind("ajaxSend", function(){
       $(this).show();
     }).bind("ajaxComplete", function(){
       $(this).hide();
    });
  }
});


$(document).ready(function(){
  $.loginSigninBox();
  $.giftInputChangeText();
  $.menuFunctionality();
  
  $.loadingAjax();
});