# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  song_id    :integer
#  user_id    :integer
#  archived   :boolean
#  favorite   :boolean
#  search     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  source_url :string(255)
#  song_url   :string(255)
#

class Post < ActiveRecord::Base
  self.per_page = 5
  belongs_to :user
  belongs_to :song

  validates :search, presence: true

  scope :current, -> { where('archived is NULL OR archived is false').
    order('created_at DESC') }
  scope :archives, -> { where(archived: true).order('created_at DESC') }
  scope :favorites, -> { where(favorite: true).order('created_at DESC') }

  after_create :detect_uri
  after_create :fillup_song

  def song
    return super() if song_id
    song = Song.new(name: search)
    self.get_service_id_from_uri.each_pair do |k,v|
      song["#{k}_id"] = v
    end
    song
  end

  def fillup_song
    options = song_url.present? ? get_service_id_from_uri : {}
    song = Song.create_from_lastfm(search, options)
    update_attributes(song_id: song.id) if song
  end

  def detect_uri
    unless song_url.present?
      if search.match(/(https?:\/\/[^\s]+)/) # youtube?
        update_attributes(song_url: search)
      elsif search.match(/\Aspotify:track:[A-Za-z0-9]+\Z/) #spotify
        update_attributes(song_url: search)
      end
    end
  end

  def get_service_id_from_uri
    @uris ||= {
      youtube: song_url.to_s[/(?<=[?&]v=)[^&$]+/, 0],
      spotify: song_url.to_s[/spotify.+track[\/|:]([^&$]+)/, 1],
      deezer: song_url.to_s[/deezer.+track[\/]([^&$]+)/, 1]
    }
  end
end
