# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  email          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  invited        :boolean          default(FALSE)
#  default_player :string(255)
#  access_token   :string(255)
#

class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :name, presence: true
  validates :access_token, uniqueness: { case_sensitive: true}, if: lambda { access_token.present? }

  has_many :authorizations, dependent: :destroy
  has_many :posts, dependent: :destroy

  after_create :update_token

  def photo
    authorizations.first.photo
  end

  def update_token
    until update_attributes(access_token: generate_tracking_code(32));end
  end

  def history
    posts.length > 0 ?
      posts.pluck(:source_url, :song_url, :search).flatten.compact : []
  end

  private
  def generate_tracking_code(length=32)
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    (0...length).map{ o[rand(o.length)] }.join + Time.now.to_i.to_s
  end
end
