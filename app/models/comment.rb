
class Comment < ApplicationRecord
  include Likable
  validates :body, length: { minimum: 3 }
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  def author_name
    author.name
  end

  def author_id
    author.id
  end

end
