# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  invited    :boolean          default(FALSE)
#

class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :name, presence: true

  has_many :authorizations, dependent: :destroy
  has_many :posts, dependent: :destroy

  def photo
    authorizations.first.photo
  end
end
