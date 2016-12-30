class RemoveAttributesFromUsers < ActiveRecord::Migration[5.0]

  def up
    remove_column :users, :birthdate, :date
    remove_column :users, :gender_id, :integer
  end

  def down
    add_column :users, :birthdate, :date
    add_column :users, :gender_id, :integer
  end

end
