class AddDeezerIdToSong < ActiveRecord::Migration
  def change
    add_column :songs, :deezer_id, :string
  end
end
