require 'active_support/concern'

module Commentable
  extend ActiveSupport::Concern

  def sorted_comments(order = :asc)
    Comment.where(commentable_id: self.id, commentable_type: self.class.name)
      .order(created_at: order).includes(:author, :likers)
  end

end
