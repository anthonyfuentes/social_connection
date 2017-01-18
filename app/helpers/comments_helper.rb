
module CommentsHelper

  def comment_delete(comment)
    if comment.author == current_user
      link_to "Delete", comments_path(comment_id: comment.id),
        method: :delete, class: "pull-right", remote: true
    end
  end

end
