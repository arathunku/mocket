class CreateArtistsTags < ActiveRecord::Migration
  def change
    create_table :artists_tags do |t|
      t.integer :artist_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
