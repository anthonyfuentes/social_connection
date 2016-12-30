class RemoveAndRenameProfilesAttributes < ActiveRecord::Migration[5.0]
  def up
    remove_column :profiles, :home_country, :string
    remove_column :profiles, :current_country, :string
    rename_column :profiles, :current_city, :current_town
  end

  def down
    add_column :profiles, :home_country, :string
    add_column :profiles, :current_country, :string
    rename_column :profiles, :current_town, :current_city
  end
end
