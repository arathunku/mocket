require "spec_helper"

describe UserHelper do
  before(:each) do
    @helper = Object.new.extend UserHelper
    @user = FactoryGirl.build(:user)
  end

  describe "#select_default_player" do
    it "returns true if player does match" do
      pending "How to fuck stub current_user?!?!"
    end
  end
end
