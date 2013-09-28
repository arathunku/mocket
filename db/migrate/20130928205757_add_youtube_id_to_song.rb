class AddYoutubeIdToSong < ActiveRecord::Migration
  def change
    add_column :songs, :youtube_id, :string
  end

  def up
    Song.all.each {|s| s.update_youtube(Song.youtube_client)}
  end
end
