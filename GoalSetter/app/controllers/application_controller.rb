class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def login!(user)
    token = user.reset_session_token!
    session[:session_token] = token
  end



end
