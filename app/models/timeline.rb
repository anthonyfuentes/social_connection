
class Timeline

  def initialize(user)
    @user = user
  end

  def posts
    Post.where("created_at is not null AND user_id = #{ user.id }")
      .order(created_at: :desc)
      .includes(:likers, :author)
  end

  private
    attr_reader :user
end
