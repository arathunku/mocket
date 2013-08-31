# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  artist_id  :integer
#  title      :string(255)
#  mbid       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  belongs_to :artist

  validates :title, presence: true
  validates :artist_id, presence: true
  validates :mbid, presence: true

  def self.find_or_create(lastfm_info, artist)
    album = Album.find_by_mbid(lastfm_info["mbid"])
    unless album
      album = Album.create(title: lastfm_info["title"],
          mbid: lastfm_info["mbid"],
          artist_id: artist.id
        )
    end
    album
  end
end
