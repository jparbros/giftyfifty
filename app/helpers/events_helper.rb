module EventsHelper
  def is_owner?
    if current_user
      @event.user == current_user
    else
      false
    end
  end
  
  def twitter_link
    link_to(image_tag('twitter_64.png'), (current_user.twitter_account)?  user_event_twitter_path(current_user, @event), :method => :post : new_my_account_twitter_path)
  end
  
  def facebook_link
    link_to(image_tag('facebook_64.png'), (current_user.facebook_account)?  user_event_facebook_path(current_user, @event), :method => :post : new_my_account_facebook_path)
  end
end