
class Friending < ApplicationRecord
  belongs_to :friender, class_name: "User", foreign_key: "friender_id"
  belongs_to :friended, class_name: "User", foreign_key: "friended_id"
  validates :friender_id, presence: true, uniqueness: { scope: :friended_id }
  validates :friended_id, presence: true, uniqueness: { scope: :friender_id }
end
