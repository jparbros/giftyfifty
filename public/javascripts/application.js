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
})(jQuery);

$(document).ready(function(){
  $.loginSigninBox();
});