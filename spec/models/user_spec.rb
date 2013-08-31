require 'spec_helper'

describe User do
  before { @user = User.new(name: "user", email: "user@mocket.com") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should have_many(:authorizations) }

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
end
