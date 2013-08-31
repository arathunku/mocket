require 'spec_helper'
include GoogleAuthInformation

describe SessionsController do
  describe "#CREATE" do
    before(:each) do
      @auth = Authorization.new(
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        user_id: 1
      )
      #@authorization = mock()
      request.env["omniauth.auth"] = auth_hash
    end
    it "sets up session" do
      Authorization.stub(:find_by_provider_and_uid).
        and_return(@auth)
      get :create
      expect(session[:user_id]).to eq(@auth.user_id)
    end

    it "creates user if does not exist" do
      Authorization.stub(:find_by_provider_and_uid).and_return(nil)
      get :create
      user = User.find_by_email(auth_hash[:info][:email])
      expect(user.email).to eq(auth_hash[:info][:email])
    end

    it "creates authorization if does not exist" do
      get :create
      authorization = Authorization.find_by_provider_and_uid(
        @auth.provider, @auth.uid)
      expect(authorization.provider).to eq(@auth.provider)
      expect(authorization.uid).to eq(@auth.uid)
    end

    it "return user from database" do
      get :create
    end
  end
end
