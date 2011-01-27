module MyAccount::ProfileHelper
  def add_twitter
    if current_user.twitter_account
      image_tag('connect_twitter.png', :class => 'connected_class')
    else
      link_to(image_tag('connect_twitter.png'), new_my_account_twitter_path, :class => 'connect_class')
    end
  end
  
  def add_facebook
    if current_user.facebook_account
      image_tag('connect_facebook.png', :class => 'connected_class')
    else
      link_to(image_tag('connect_facebook.png'), new_my_account_facebook_path, :class => 'connect_class')
    end
  end
  
  def unique_url(user)
    (user.username.nil? || user.username.empty?)? '' : personal_urls_url(user.username)
  end
end
