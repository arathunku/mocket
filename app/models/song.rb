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
  include LastfmGetter

  belongs_to :artist

  validates :name, presence: true
  validates :mbid, presence: true, uniqueness: true

  def self.create_from_lastfm(information)
    info = lastfm_information(information)
    if info && info["track"]
      track = info["track"]
      artist = Artist.find_or_create(track["artist"])
      artist.fill_up_tags(track["toptags"]["tag"])
      album = Album.find_or_create(track["album"], artist)

      song = artist.songs.create(
        name: track["name"],
        mbid: track["mbid"],
        album_id: album.id
      )
    end
    song
  end

  def tags
    []
  end

  def self.lastfm_information(information)
    link = create_link("track.search", {track: information})
    json = get_json_from(link)
    if json["results"] && json["results"]["opensearch:totalResults"].to_i > 0
      song = json["results"]["trackmatches"]["track"].first
      link = create_link("track.getInfo", {mbid: song["mbid"]})
      json = get_json_from(link)
    end
    json
  end
end
