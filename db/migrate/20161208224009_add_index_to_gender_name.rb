class AddIndexToGenderName < ActiveRecord::Migration[5.0]
  def up
    add_index :genders, :name, unique: true
  end

  def down
    remove_index :genders, column: :name
  end
end
