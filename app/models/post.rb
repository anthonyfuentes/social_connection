
class Post < ApplicationRecord
  include Commentable
  include Likable
  validates :body, presence: true
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :likes, as: :likable
  has_many :likers, through: :likes, source: :user
  has_many :comments, as: :commentable, dependent: :destroy

  def author_id
    author.id
  end

end
