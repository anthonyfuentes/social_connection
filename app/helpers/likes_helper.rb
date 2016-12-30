
module LikesHelper

  def like_link(likable)
    if likable.liked_by?(current_user)
      unlike_link(likable)
    else
      create_like_link(likable)
    end
  end

  def unlike_link(likable)
    likable_type = type(likable)
    link_to "Unlike", likes_path(likable_id: likable.id,
                                 likable_type: likable_type), method: :delete
  end

  def create_like_link(likable)
    likable_type = type(likable)
    link_to "Like", likes_path(likable_id: likable.id,
                               likable_type: likable_type), method: :post
  end

  def type(likable)
    likable.class.name
  end

  def likers_display(post, count = 2)
    likers = post.likers
    if likers.length > 1
      like_display = multiple_likers(likers, count)
    elsif likers.length == 1
      like_display = single_liker(likers[0])
    else
      like_display = ""
    end
    like_display.html_safe
  end

  def single_liker(liker)
    liker_link = liker_link(liker)
    if liker == current_user
      "#{liker_link } like this.".html_safe
    else
      "#{liker_link } likes this.".html_safe
    end
  end

  def multiple_likers(likers, count)
    likers = move_current_user_to_front(likers)
    if likers.length > count
      display = joined_likers(likers, count)
    else
      display = named_likers(likers)
    end
    "#{ display } like this."
  end

  def move_current_user_to_front(likers)
    if likers.include?(current_user)
      likers = likers - [current_user]
      likers.unshift(current_user)
    end
    likers
  end

  def named_likers(likers)
    display = ""
    likers.each_with_index do |liker, index|
      display << display_for(liker, index, likers.length)
    end
    display
  end

  def unnamed_likers(likers)
    "#{ likers.length } others"
  end

  def display_for(liker, index, liker_count)
    liker_link = liker_link(liker)
    if index == liker_count - 1
      display = "#{ liker_link }"
    elsif index == liker_count - 2
      display = "#{ liker_link } and "
    else
      display = "#{ liker_link }, "
    end
  end

  def liker_link(user)
    if user == current_user
      link_to("You", user_profile_path(user))
    else
      link_to(user.name, user_timeline_path(user))
    end
  end
end
