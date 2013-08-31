require 'spec_helper'

describe UsersController do
  describe "#SETTINGS" do
    context "unauthorized" do
      before do
        get :settings
      end
      it { should respond_with(:redirect) }
    end

    context "authorized" do
      before do
        user = FactoryGirl.create(:user)
        session[:user_id] = user.id
        get :settings
      end
      it { should render_template("settings") }
    end
  end
end
