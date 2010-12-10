class MainController < ApplicationController
  def index; end
  
  def redirect; end
  
  def blank
    render :text => 'Success'
  end
end
