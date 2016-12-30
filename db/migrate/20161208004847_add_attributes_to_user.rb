class AddAttributesToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthdate, :date
    add_column :users, :gender_id, :integer
  end

  def down

  end
end
