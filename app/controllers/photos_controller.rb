
class PhotosController < ApplicationController
  skip_before_action :correct_user, only: [:index, :show]
  before_action :require_friends, only: [:index, :show]

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    @photo.save ? successful_create : failed_create
  end

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find_by(id: params[:id], user_id: @user.id)
  end

  def destroy
    Photo.find(params[:id]).destroy
    redirect_to user_photos_path(params[:user_id])
  end

  private

    def successful_create
      flash[:success] = 'Photo uploaded!'
      redirect_to user_photo_url(current_user, @photo)
    end

    def failed_create
      flash.now[:danger] = 'Something went wrong, please make sure the
      file is an image type'
      render :new
    end

    def photo_params
      params.require(:photo).permit(:file)
    end

    def require_friends
      user = @user || User.find(params[:user_id])
      unless user.friend_or_self?(current_user)
        flash[:danger] = "You have to be friends to see #{ user.name }'s pictures"
        redirect_back
      end
    end
end
