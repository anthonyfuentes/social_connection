
class Newsfeed

  def initialize(user)
    @user = user
  end

  def recently_active_friends
    User.where(id: user.friends_ids)
  end

  def posts
    Post.where(user_id: post_author_ids)
      .order(created_at: :desc)
      .includes(:author, :likers, :likes)
  end

  private
    attr_reader :user

    def post_author_ids
      user.friends_ids << user.id
    end

end
