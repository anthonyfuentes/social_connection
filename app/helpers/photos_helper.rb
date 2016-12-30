
module PhotosHelper

  def profile_photo(id:, size: :medium, styling: '')
    if profile_photo = User.find(id).profile_photo
      image_tag profile_photo.expiring_url(3600, size),
        class: styling
    else
      default_picture(size, styling)
    end
  end

  def cover_photo(id:, styling: '')
    if cover_photo = User.find(id).cover_photo
      cover_photo.url(:cover)
    end
  end

  def default_picture(size, styling)
    size = size_for(size)
    image_tag 'user_silhouette_generic.png',
      style: "max-width: #{size}"
  end

  def photo_count(user_id)
    Photo.where(user_id: user_id).count
  end

  def add_photo_link(user_id)
    if current_user.id == user_id
      link_to "Add Photo", new_user_photo_path(current_user.id),
        class: 'btn btn-primary pull-right'
    end
  end

  def cover_photo_link(user_id, photo)
    if current_user.id == user_id && current_user.cover_photo != photo
      create_cover_photo_link(current_user, photo.id)
    end
  end

  def profile_photo_link(user_id, photo)
    if current_user.id == user_id && current_user.profile_photo != photo
      create_profile_photo_link(current_user, photo.id)
    end
  end

  def delete_photo_link(user_id, photo)
    if current_user.id == user_id
      link_to "Delete Photo", user_photo_path(user_id, photo.id),
        method: :delete
    end
  end

  def view_photo_link(id:, photo:, size: :medium, styling: '')
    user = User.find(id)
    if user.friend_or_self?(current_user)
      link_to image_tag(photo.expiring_url(3600, size)),
        user_photo_path(id, photo.id)
    else
      image_tag photo.expiring_url(3600, size), class: styling
    end
  end

  private

  def create_profile_photo_link(user, photo_id)
    link_to "Make Profile Photo",
      user_profile_path(user, profile: { id: user.profile.id,
                                         profile_photo_id: photo_id }),
                                         method: :patch
  end

  def create_cover_photo_link(user, photo_id)
    link_to "Make Cover Photo",
      user_profile_path(user, profile: { id: user.profile.id,
                                         cover_photo_id: photo_id }),
                                         method: :patch
  end

  def size_for(size)
    if size == :tiny
      '65px'
    elsif size == :thumb
      '85px'
    elsif size == :small
      '125px'
    elsif size == :medium
      '200px'
    end
  end

end
