class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :name, presence: true

  has_many :authorizations
end