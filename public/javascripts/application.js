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
        $.jGrowl('Please, Insert a valid url.', { header: 'Important', sticky: true });
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
  }
});


$(document).ready(function(){
  $.loginSigninBox();
  $.giftInputChangeText();
  $.menuFunctionality();
});