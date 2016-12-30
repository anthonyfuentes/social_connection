class RemoveAttributesFromProfile < ActiveRecord::Migration[5.0]

  def up
    remove_column :profiles, :phone_number, :string
    remove_column :profiles, :words_to_live_by, :text
  end

  def down
    add_column :profiles, :phone_number, :string
    add_column :profiles, :words_to_live_by, :text
  end

end
