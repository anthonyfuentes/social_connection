
class CommentsController < ApplicationController
  skip_before_action :correct_user, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save ? successful_create : failed_create
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy ? successful_destroy : failed_destroy
  end

  private
    def successful_create
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.js { render :comment_create_success }
      end
    end

    def failed_create
      flash[:danger] = @comment.errors.full_messages
      redirect_to request.referrer
    end

    def successful_destroy
      redirect_to request.referrer
    end

    def failed_destroy
      redirect_to request.referrer
    end

    def comment_params
      params.require(:comment).permit(:body,
                                      :commentable_id, :commentable_type)
    end
end
