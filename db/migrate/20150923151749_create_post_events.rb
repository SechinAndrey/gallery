class CreatePostEvents < ActiveRecord::Migration
  def change
    create_table :post_events do |t|
      t.integer :user_id
      t.string :username
      t.string :action
      t.integer :post_id
      t.string :post_name

      t.timestamps null: false
    end
  end
end
