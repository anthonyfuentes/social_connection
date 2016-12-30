
class ProfilesController < ApplicationController
  before_action :get_profile, only: [:show, :edit, :update]
  before_action :get_user, only: [:show, :edit]
  skip_before_action :correct_user, only: [:show]

  def show
  end

  def edit
  end

  def update
    @profile.update(profile_params) ? successful_update : failed_update
  end

  private
    def correct_user
      super("You can only edit your profile")
    end

    def get_profile
      @profile = Profile.find_by(user_id: params[:user_id])
    end

    def get_user
      @user = User.find_by(id: params[:user_id])
    end

    def successful_update
      flash[:success] = "Profile Updated"
      redirect_to user_profile_path(params[:user_id])
    end

    def failed_update
      flash[:danger] = @profile.errors.full_messages
      render :edit
    end

    def profile_params
      params.require(:profile).permit(:education, :home_town, :current_town,
                                      :about_me, :profile_photo_id,
                                      :cover_photo_id)
    end
end
