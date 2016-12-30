
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :correct_user

  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies[:auth_token] = nil
  end

  def current_user
    if cookies[:auth_token]
      @current_user ||= User.find_by(auth_token: cookies[:auth_token])
    end
  end
  helper_method :current_user

  def user_signed_in?
    !!current_user
  end
  helper_method :user_signed_in?

  def correct_user(msg = 'You\'re not authorized to do that')
    id = params[:user_id].to_i
    unless current_user.id == id
      flash[:danger] = msg
      redirect_to root_url
    end
  end

  def require_login
    unless user_signed_in?
      flash[:danger] = "Please sign in."
      redirect_to root_url
    end
  end

  def redirect_back
    if referrer = request.referrer
      redirect_to referrer
    else
      redirect_to root_url
    end
  end

end
