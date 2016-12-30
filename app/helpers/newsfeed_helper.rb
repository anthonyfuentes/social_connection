
module NewsfeedHelper

  def newsfeed_link(user_id)
    if current_user.id == user_id
      link_to "Newsfeed", user_newsfeed_path
    end
  end
end
