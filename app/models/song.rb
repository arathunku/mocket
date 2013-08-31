# == Schema Information
#
# Table name: songs
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  artist_id   :integer
#  lastfm_link :string(255)
#  mbid        :string(255)
#  album_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Song < ActiveRecord::Base
  belongs_to :artist

  validates :name, presence: true
  validates :mbid, presence: true, uniqueness: true

  def self.create_from_lastfm(information)
    info = lastfm_information(information)
    if info && info["track"]
      track = info["track"]
      artist = Artist.find_or_create(track["artist"])

      song = artist.songs.create(
        name: track["name"],
        mbid: track["mbid"],
        lastfm_link: track["link"]
      )
    end
    song
  end


  def self.lastfm_information(information)
    return {}
  end
end
