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
  AVAILABLE_SERVICES = [:youtube, :spotify, :deezer]

  belongs_to :artist

  validates :name, presence: true
  validates :mbid, presence: true, uniqueness: true

  def self.create_from_lastfm(information, service={})
    song = Song.new
    AVAILABLE_SERVICES.each do |service_key|
      if service.has_key?(service_key) && service[service_key].present?
        song["#{service_key.to_s}_id"] = service[service_key]
        title = song.send("get_#{service_key.to_s}_information")
        information = title if title
      end
    end

    lastfm_data = lastfm_information(information)
    if lastfm_data && lastfm_data["track"]
      track = lastfm_data["track"]
      artist = Artist.find_or_create(track["artist"])
      artist.fill_up_tags(track["toptags"]["tag"])
      album = Album.find_or_create(track["album"], artist)
      previous_song = Song.where(mbid: track["mbid"]).first
      song = previous_song if previous_song
      unless song.id
        song.artist_id = artist.id
        song.mbid = track["mbid"]
        song.album_id = album.id if album
        song.name = track["name"]
        song.save

        hash = {}
        AVAILABLE_SERVICES.each do |service_key|
          if !service.has_key?(service_key) && !service[service_key].present?
            id = song.send("get_#{service_key.to_s}")
            hash["#{service_key.to_s}_id"] = id if id
          end
        end
        song.update_attributes(hash) if hash.keys.length > 0
      end
    end
    song
  end

  def self.lastfm_information(information)
    information = cleanup_chars(information)
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

  def self.cleanup_chars(text)
    # encoding_options = {
    #   :invalid           => :replace,  # Replace invalid byte sequences
    #   :undef             => :replace,  # Replace anything not defined in ASCII
    #   :replace           => '',        # Use a blank for those replacements
    #   :universal_newline => true       # Always break lines with \n
    # }
    # text.encode(Encoding.find('ASCII'), encoding_options)
    text
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
    @services ||= AVAILABLE_SERVICES.map do |service|
      self.send(service) if self.attributes["#{service.to_s}_id"]
    end
      .compact
  end

  def services_names
    services.map(&:name)
  end

  def get_youtube
    result = Youtube.videos_by(query: full_name, page: 1,
      per_page: 1).videos.first
    result ? result.unique_id : nil
  end

  def get_spotify
    Spotify.get_id(full_name)
  end

  def get_deezer
    Deezer.get_id(full_name)
  end

  def get_youtube_information
    Youtube.get_information(youtube_id)
  end

  def get_spotify_information
    Spotify.get_information(spotify_id)
  end

  def get_deezer_information
    Deezer.get_information(youtube_id)
  end
end
