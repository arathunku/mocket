require 'spec_helper'

describe SettingsController do
  describe "access to user sites" do
    [:default, :api].each do |site|
      it "not logged" do
        get site
        expect(response.status).to eq(302)
      end
    end
  end

  describe "actions" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    describe "#update" do
      it "updates permited attributes" do
        User.any_instance.should_receive(:update_attributes).
          with({"default_player"=> 'spotify'}).and_return(true)
        patch :update, {user: {default_player: 'spotify'}}
        expect(response.status).to eq(302)
        expect(flash.notice).to be(nil)
      end
      it "updates permited attributes" do
        User.any_instance.should_receive(:update_attributes).and_return(nil)
        patch :update, {user: {email: 'spotify'}}
        expect(response.status).to eq(302)
        expect(flash.notice.to_s).to match(/problem/)
      end
    end
  end
end
