# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  photo      :string(255)
#  provider   :string(255)
#  uid        :string(255)
#  link       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Authorization < ActiveRecord::Base
  belongs_to :user

  validates :uid, presence: true
  validates :provider, presence: true
end
