class DropGenders < ActiveRecord::Migration[5.0]

  def change
    drop_table :genders
  end

end
