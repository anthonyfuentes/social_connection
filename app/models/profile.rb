
class Profile < ApplicationRecord
  belongs_to :user

  def birthdate
    user.birthdate
  end

  def email
    user.email
  end

  def name
    user.name
  end

  def cover_photo
    Photo.where(id: cover_photo_id).first
  end

  def profile_photo
    Photo.where(id: profile_photo_id).first
  end

end
