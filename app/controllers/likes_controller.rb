
class LikesController < ApplicationController
  skip_before_action :correct_user, only: [:create, :destroy]

  def create
    @like = Like.new(likable_id: params[:likable_id],
                     likable_type: params[:likable_type],
                     user_id: current_user.id)
    @like.save
    redirect_to request.referrer
  end

  def destroy
    @like = Like.where(likable_id: params[:likable_id].to_i,
                     likable_type: params[:likable_type],
                     user_id: current_user.id).first
    @like.destroy
    redirect_to request.referrer
  end
end
