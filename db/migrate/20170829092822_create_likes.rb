class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :pin_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
