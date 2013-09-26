class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :song_id
      t.integer :user_id
      t.boolean :archived
      t.boolean :favorite
      t.string :search

      t.timestamps
    end
  end
end
