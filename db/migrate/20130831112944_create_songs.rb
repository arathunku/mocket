class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :artist_id
      t.string :lastfm_link
      t.string :mbid
      t.integer :album_id

      t.timestamps
    end
  end
end
