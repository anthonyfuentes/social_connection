
class UpdateProfileAttributes < ActiveRecord::Migration[5.0]
  def up
    add_column :profiles, :education, :string
    add_column :profiles, :home_town, :string
    add_column :profiles, :home_country, :string
    add_column :profiles, :current_city, :string
    add_column :profiles, :current_country, :string
    add_column :profiles, :phone_number, :string
    add_column :profiles, :words_to_live_by, :text
    add_column :profiles, :about_me, :text
  end

  def down
    remove_column :profiles, :education, :string
    remove_column :profiles, :home_town, :string
    remove_column :profiles, :home_country, :string
    remove_column :profiles, :current_city, :string
    remove_column :profiles, :current_country, :string
    remove_column :profiles, :phone_number, :string
    remove_column :profiles, :words_to_live_by, :text
    remove_column :profiles, :about_me, :text
  end
end
