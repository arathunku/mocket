# == Schema Information
#
# Table name: artists
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  mbid        :string(255)
#  lastfm_link :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Artist < ActiveRecord::Base
  has_many :songs

  validates :mbid, presence: true, uniqueness: { case_sensitive: false}
  validates :name, presence: true, uniqueness: true


  def self.find_or_create(lastfm_info)
    artist = Artist.find_by_mbid(lastfm_info["mbid"])
    unless artist
      artist = Artist.create(name: lastfm_info["name"],
          mbid: lastfm_info["mbid"],
          lastfm_link: lastfm_info["link"],
        )
    end
    artist
  end
end
