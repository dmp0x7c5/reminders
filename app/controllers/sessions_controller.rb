class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, except: :destroy
  before_action :validate_auth_hash!, only: :create

  expose(:auth) { request.env["omniauth.auth"] }

  def new
    redirect_to "/auth/google_oauth2"
  end

  def create
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

  private

  def validate_auth_hash!
    return if auth["info"]
    redirect_to action: :failure,
                message: "missing info date in the account."
  end
end
