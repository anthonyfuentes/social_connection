class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def up
    add_index :users, :email, unique: true
  end

  def down
    remove_index :users, column: :email
  end
end
