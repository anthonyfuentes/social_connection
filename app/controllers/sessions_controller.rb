
class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]
  skip_before_action :correct_user, only: [:create, :destroy]

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      successful_sign_in
    else
      failed_sign_in
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed out"
    redirect_to root_url
  end

  private

    def failed_sign_in
      flash.now[:danger] = "Something's not quite right"
      redirect_to root_url
    end

    def successful_sign_in
      sign_in_conditionally(@user)
      flash[:success] = "Signed In"
      redirect_to user_newsfeed_url(current_user)
    end

    def sign_in_conditionally(user)
      params[:remember_me] ? permanent_sign_in(user) : sign_in(user)
    end
end
