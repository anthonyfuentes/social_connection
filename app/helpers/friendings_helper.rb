
module FriendingsHelper

  def friend_count(user_id)
    Friending.where("friended_id = :user_id OR friender_id = :user_id",
                    user_id: user_id).count
  end

  def user_friend_link(other_user_id)
    other_user = User.find(other_user_id)
    if current_user == other_user
      return
    elsif friends?(current_user, other_user)
      unfriend_link(other_user_id)
    else
      friend_link(other_user_id)
    end
  end

  private
  def friends?(current_user, other_user)
    current_user.friended_users.include?(other_user) ||
      current_user.users_friended_by.include?(other_user)
  end

  def friend_link(other_user_id)
    link_to "Friend Me", friendings_path(user_id: other_user_id),
                method: :post,
                class: friend_link_styling,
                style: "color:#fff",
                remote: true
  end

  def unfriend_link(other_user_id)
    link_to "Unfriend", part_ways_path(user_id: other_user_id),
                class: friend_link_styling,
                style: "color:#fff",
                remote: true
  end

  def friend_link_styling
    "btn btn-primary btn-friend navbar-text"
  end
end
