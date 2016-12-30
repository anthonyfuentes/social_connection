
class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    @post.save ? successful_create : failed_create
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy ? successful_delete : failed_delete
  end

  private
    def successful_create
      redirect_to request.referer
    end

    def failed_create
      flash[:danger] = @post.errors.full_messages
      redirect_to request.referer
    end

    def successful_delete
      flash[:success] = "#{ @post.body[0..25] } Deleted"
      redirect_to request.referer
    end

    def failed_delete
      flash[:danger] = "Something isn't quite right, give us a sec"
      redirect_to request.referer
    end

    def post_params
      params.require(:post).permit(:body)
    end
end
