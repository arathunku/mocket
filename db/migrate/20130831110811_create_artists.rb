class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :mbid
      t.string :lastfm_link

      t.timestamps
    end
  end
end
