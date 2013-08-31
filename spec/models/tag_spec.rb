# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Tag do
  before { @tag = Tag.new(name: "tag") }

  subject { @tag }

  it { should respond_to(:name) }

  it { should have_and_belong_to_many(:artists) }

  it { should be_valid }

  context "validations: " do
    describe "name not present" do
      before { @tag.name = '' }
      it { should_not be_valid }
    end

    describe "name taken" do
      before do
        tag_same_name = @tag.dup
        tag_same_name.save
      end
      it { should_not be_valid }
    end
  end
end
