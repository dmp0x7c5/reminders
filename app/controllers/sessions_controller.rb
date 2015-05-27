class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, except: :destroy

  def new
    redirect_to "/auth/google_oauth2"
  end

  def create
    auth = request.env["omniauth.auth"]
    user = UsersRepository.new.from_auth(auth)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url,
                alert: "Authentication error: #{params[:message].humanize}"
  end
end
