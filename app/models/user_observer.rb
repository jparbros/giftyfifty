class UserObserver < ActiveRecord::Observer
  def after_update(user)
    account_confirmation(user)
  end
  
  def account_confirmation(user)
    UserMailer.register_confirmation(user).deliver
  end
end
