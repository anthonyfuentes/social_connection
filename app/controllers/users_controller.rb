
class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :correct_user, only: [:new, :create, :index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save ? successful_create : failed_create
  end

  def index
    @users = User.search(name: params[:term],
                         user: current_user)
  end

  private
    def successful_create
      @user.create_profile
      sign_in(@user)
      flash[:success] = "Welcome to Social Connection!"
      User.send_welcome_email(@user.id)
      redirect_to user_profile_url(current_user)
    end

    def failed_create
      flash[:danger] = @user.errors.full_messages
      render :new
    end

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name,
                                   :password, :password_confirmation)
    end
end
