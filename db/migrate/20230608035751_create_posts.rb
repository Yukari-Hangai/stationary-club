class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.timestamps
      t.integer :user_id, null: false
      t.text :text, null: false
    end
  end
end
