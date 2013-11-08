class AddSourceUrlAndSongUrlToPost < ActiveRecord::Migration
  def change
    add_column :posts, :source_url, :string
    add_column :posts, :song_url, :string
  end
end
