
module PostsHelper

  def post_delete(post)
    if post.author == current_user
      link_to "Delete", user_post_path(id: post.id),
        method: :delete, class: "pull-right"
    end
  end

  def joined_likers(likers, count)
    named, unnamed = likers[0...count], likers[count..-1]
    "#{ named_likers(named) } and #{ unnamed_likers(unnamed) }"
  end

end
