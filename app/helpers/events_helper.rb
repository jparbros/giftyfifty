module EventsHelper
  def is_owner?
    if current_user
      @event.user == current_user
    else
      false
    end
  end
  
  def twitter_link
    if current_user.twitter_account
      link_to(image_tag('share-twitter.png'), event_twitter_path(@event, :message => 'event'), :method => :post)
    else
      link_to(image_tag('twitter_64.png') + 'Link your account', new_my_account_twitter_path)
    end
  end
  
  def facebook_link
    if current_user.facebook_account
      link_to(image_tag('share-facebook.png'), event_facebook_path(@event, :message => 'event'), :method => :post )
    else
      link_to(image_tag('facebook_64.png') + 'Link your account', new_my_account_facebook_path)
    end
  end
end