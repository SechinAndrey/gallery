class CreateUserProviders < ActiveRecord::Migration
  def change
    create_table :user_providers do |t|
      t.integer :user_id
      t.string :provider
      t.integer :uid

      t.timestamps null: false
    end
  end
end
