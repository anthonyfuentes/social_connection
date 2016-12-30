
class Profile < ApplicationRecord
  belongs_to :user

  def cover_photo
    Photo.where(id: cover_photo_id).first
  end

  def profile_photo
    Photo.where(id: profile_photo_id).first
  end

end
