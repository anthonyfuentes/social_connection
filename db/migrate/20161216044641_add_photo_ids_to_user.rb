
class AddPhotoIdsToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :profile_photo_id, :integer
    add_column :users, :cover_photo_id, :integer
  end

  def down
    remove_column :users, :profile_photo_id, :integer
    remove_column :users, :cover_photo_id, :integer
  end
end
