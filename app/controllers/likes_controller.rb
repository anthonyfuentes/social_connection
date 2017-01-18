
class LikesController < ApplicationController
  skip_before_action :correct_user, only: [:create, :destroy]

  def create
    @like = Like.new(likable_id: params[:likable_id],
                     likable_type: params[:likable_type],
                     user_id: current_user.id)
    @like.save ? successful_create : failed_create
  end

  def destroy
    @like = Like.where(likable_id: params[:likable_id].to_i,
                     likable_type: params[:likable_type],
                     user_id: current_user.id).first
    @like.destroy ? successful_destroy : failed_destroy
  end

  private
    def successful_create
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js { render :like_create_success }
      end
    end

    def failed_create
    end

    def successful_destroy
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js { render :like_destroy_success }
      end
    end

    def failed_destroy
    end
end
