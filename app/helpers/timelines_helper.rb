module TimelinesHelper

  def post_form(user_id)
    if current_user.id == user_id
      render 'posts/post_form'
    end
  end

end
