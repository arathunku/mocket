require 'spec_helper'

describe UsersController do
  describe "access to user sites" do
    [:settings, :dashboard, :archives, :favorites].each do |site|
      it "not logged" do
        get site
        expect(response.status).to eq(302)
      end

      it "logged but not invited" do
        user = FactoryGirl.create(:user)
        session[:user_id] = user.id
        get site
        expect(response.status).to eq(302)
      end

      it "logged and invited" do
        user = FactoryGirl.create(:user, invited: true)
        session[:user_id] = user.id
        get site
        expect(response.status).to eq(200)
      end
    end
  end
end
