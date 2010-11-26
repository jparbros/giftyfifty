class SessionsController < ApplicationController
  #include Devise::Controllers::InternalHelpers 
  
  def login
    debugger
    resource = warden.authenticate!(:scope => 'user')
    debugger
    resource.load_token
    set_flash_message :notice, :signed_in
    sign_in_and_redirect('user', resource)
  end
  
end
