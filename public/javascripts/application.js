$.fn.extend({
  getGiftUrl: function(){
    console.log(this.selector);
    this.click(function(){
      giftInput = $('input#gift_url');
      loginGiftInputs = $('#new_user #gift_url');
      gift_url = giftInput.attr('value');
      loginGiftInputs.attr('value',gift_url);
      $('#login-box #providers a').each(function(){
         _href = this.href;
          this.href = _href + '?gift_url=' + gift_url
      });
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
  
  loginSigninBox: function() {
    $('a#sigin-link, a#login-link, input#go-sign-in').click(function(){
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
    menuToggle = $('div#login div#user-menu');
    menuContent = $('div#login ul#menu-content');
    menuElements = $('#menu-content li');
    loginBox = $('div#login');
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
  }
});


$(document).ready(function(){
  $.loginSigninBox();
  $.giftInputChangeText();
  $.menuFunctionality();
});