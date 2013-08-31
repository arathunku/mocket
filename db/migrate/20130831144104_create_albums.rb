class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :artist_id
      t.string :title
      t.string :mbid

      t.timestamps
    end
  end
end
