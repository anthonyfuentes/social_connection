class MovePhotoIdsToProfile < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :profile_photo_id, :integer
    remove_column :users, :cover_photo_id, :integer
    add_column :profiles, :profile_photo_id, :integer
    add_column :profiles, :cover_photo_id, :integer
  end

  def down
    add_column :users, :profile_photo_id, :integer
    add_column :users, :cover_photo_id, :integer
    remove_column :profiles, :profile_photo_id, :integer
    remove_column :profiles, :cover_photo_id, :integer
  end

end
