class SessionsController < ApplicationController
  def create
    @auth = request.env["rack.auth"]
  end
end
