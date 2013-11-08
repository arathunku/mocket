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

  after_create :fillup_song

  def song
    return super() if super()
    Song.new(name: search)
  end

  def fillup_song
    song = Song.create_from_lastfm(search)
    update_attribute(:song_id, song.id) if song
  end
end
