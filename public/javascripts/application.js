(function($){
  $.loginSigninBox = function() {
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
  };
  $.loadFacebook = function() {
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
  };
  $.giftInputChangeText = function() {
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
  };

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

  $.menuFunctionality = function() {
    menuToggle = $('div#login div#user-menu');
    menuContent = $('div#login ul#menu-content');
    menuElements = $('#menu-content li');
    loginBox = $('div#login');
    menuToggle.click(function(){
      menuStyle();
      menuContent.toggle();
    });
  }
})(jQuery);

$(document).ready(function(){
  $.loginSigninBox();
  $.giftInputChangeText();
  $.menuFunctionality();
});