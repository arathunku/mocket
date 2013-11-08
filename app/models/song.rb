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
#  youtube_id  :string(255)
#  spotify_id  :string(255)
#  deezer_id   :string(255)
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

      song = Song.where(mbid: track["mbid"]).first
      song ||= artist.songs.create(
        name: track["name"],
        mbid: track["mbid"],
        album_id: album.id
      )
      song.update_youtube
      song.update_spotify
      song.update_deezer
    end
    song
  end

  def self.lastfm_information(information)
    link = create_link("track.search", {track: information})
    json = get_json_from(link)
    if json["results"] && json["results"]["opensearch:totalResults"].to_i > 0
      song = json["results"]["trackmatches"]["track"].first
      return nil if song.class != Hash || !song["mbid"].present?
      link = create_link("track.getInfo", {mbid: song["mbid"]})
      json = get_json_from(link)
    end
    json
  end

  def full_name
    if artist
      "#{artist.name} - #{name}"
    else
      "#{name}"
    end
  end

  def tags
    []
  end

  def youtube
    if youtube_id
      @youtube ||= Youtube.new(youtube_id)
    else
      nil
    end
  end

  def spotify
    if spotify_id
      @spotify ||= Spotify.new(spotify_id)
    else
      nil
    end
  end

  def deezer
    if deezer_id
      @deezer ||= Deezer.new(deezer_id)
    else
      nil
    end
  end

  def services
    ['youtube', 'spotify', 'deezer'].map{|e| self.send(e)}.compact
  end

  def update_youtube
    result = Youtube.videos_by(query: full_name, page: 1,
      per_page: 1).videos.first
    update_attributes(youtube_id: result.unique_id) if result
  end

  def update_spotify
    id = Spotify.get_id(full_name)
    update_attributes(spotify_id: id) if id
  end

  def update_deezer
    id = Deezer.get_id(full_name)
    update_attributes(deezer_id: id) if id
  end
end
