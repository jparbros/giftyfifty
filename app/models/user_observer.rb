class UserObserver < ActiveRecord::Observer
  def after_create(user)
    account_confirmation(user)
  end
  
  def account_confirmation(user)
    begin
      UserMailer.register_confirmation(user).deliver
    rescue Exception => e
    end
  end
end
