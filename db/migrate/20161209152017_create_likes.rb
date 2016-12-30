class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.integer :likable_id
      t.string :likable_type

      t.timestamps
    end
    add_index :likes, [:likable_type, :likable_id]
    add_index :likes, [:likable_type, :likable_id, :user_id], unique: true
  end
end
