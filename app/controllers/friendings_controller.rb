
class FriendingsController < ApplicationController
  skip_before_action :correct_user, only: [:create, :destroy, :index]

  def index
    @user = User.find(params[:user_id])
  end

  def create
    @friending = Friending.new(friender_id: current_user.id,
                               friended_id: params[:user_id])
    @friending.save ? successful_create : failed_create
  end

  def destroy
    @friending = Friending.where(friender_id: current_user.id,
                                friended_id: params[:user_id].to_i)[0]
    @friending.destroy ? successful_destroy : failed_destroy
  end

  private
    def successful_create
      flash[:success] = "Friend added."
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js { render :friending_create_success }
      end
    end

    def failed_create
      redirect_to request.referrer
    end

    def successful_destroy
      flash[:success] = "User unfriended."
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js { render :friending_destroy_success }
      end
    end

    def failed_destroy
      flash[:danger] = "Something didn't quite work - we'll get right on it."
      redirect_to request.referrer
    end
end
