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

require 'spec_helper'

describe Authorization do
  before(:each) { @auth = Authorization.new(provider: "google_oauth2", user_id: 1, uid: "2") }

  subject { @auth }

  it { should respond_to(:provider) }
  it { should respond_to(:user_id) }
  it { should respond_to(:uid) }
  it { should respond_to(:photo) }
  it { should respond_to(:link) }

  it { should belong_to(:user) }
  it { should be_valid }

  context "validations: " do
    it "provider not present" do
      @auth.provider = ''
      expect(@auth.valid?).to be_false
    end
    it "uid not present" do
      @auth.uid = ''
      expect(@auth.valid?).to be_false
    end
  end

  context "method: " do

  end
end
