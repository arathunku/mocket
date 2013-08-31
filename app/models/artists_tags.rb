# == Schema Information
#
# Table name: artists_tags
#
#  id         :integer          not null, primary key
#  artist_id  :integer
#  tag_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class ArtistsTags < ActiveRecord::Base
  belongs_to :artist
  belongs_to :tag

  validates :tag_id, :uniqueness => {:scope => :artist_id}, presence: true
  validates :artist_id, presence: true
end
