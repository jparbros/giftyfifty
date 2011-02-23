module EventsHelper
  def is_owner?
    if current_user
      @event.user == current_user
    else
      false
    end
  end
  
  def twitter_account?
    current_user.twitter_account
  end
  
  def facebook_account?
    current_user.facebook_account
  end
  
  def twitter_link
    if twitter_account?
      link_to(image_tag('share-twitter.png'), '', :id => 'twitter-share-link')
    else
      link_to(image_tag('connect_twitter.png'), new_my_account_twitter_path)
    end
  end
  
  def facebook_link
    if facebook_account?
      link_to(image_tag('share-facebook.png'), '', :id => 'facebook-share-link')
    else
      link_to(image_tag('connect_facebook.png'), new_my_account_facebook_path)
    end
  end
end