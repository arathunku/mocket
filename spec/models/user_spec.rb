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

require 'spec_helper'

describe User do
  before { @user = User.new(name: "user", email: "user@mocket.com") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:access_token) }

  it { should have_many(:authorizations) }
  it { should have_many(:posts) }

  it { should be_valid }

  context "validations: " do
    describe "when name is not present" do
      before { @user.name = '' }
      it { should_not be_valid }
    end

    describe "when email is not present" do
      before { @user.email = '' }
      it { should_not be_valid }
    end

    describe "email already taken" do
      before do
        user_same_email = @user.dup
        user_same_email.save
      end

      it { should_not be_valid }
    end
  end

  context "callbacks" do
    it "calls for update token after create" do
      User.any_instance.stub(:update_token)
      User.any_instance.should_receive(:update_token)
      @user.save
    end
  end

  context "methods" do
    describe "#update_token" do
      it "updates user token until token unique" do
        User.any_instance.should_receive(:update_attributes).twice.and_return(nil, true)
        @user.update_token
      end
    end

    describe "#history" do
      it "array of post history" do
        Post.any_instance.stub(:fillup_song)
        post = FactoryGirl.create(:post, user: @user, song_url: nil)
        expect(@user.history).to match_array([post.search, post.source_url])
      end
    end
  end
end
