
class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    @post.save ? successful_create : failed_create
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy ? successful_destroy : failed_destroy
  end

  private
    def successful_create
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.js { render :post_create_success }
      end
    end

    def failed_create
      flash[:danger] = @post.errors.full_messages
      redirect_to request.referer
    end

    def successful_destroy
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.js { render :post_destroy_success }
      end
    end

    def failed_destroy
      flash[:danger] = "Something isn't quite right, give us a sec"
      redirect_to request.referer
    end

    def post_params
      params.require(:post).permit(:body)
    end
end
