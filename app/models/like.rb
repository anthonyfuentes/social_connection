
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true
  validates :user_id, uniqueness: { scope: [:likable_id, :likable_type] }

  def user_name
    user.name
  end

end
