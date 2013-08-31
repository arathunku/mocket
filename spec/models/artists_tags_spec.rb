# == Schema Information
#
# Table name: artists_tags
#
#  id         :integer          not null, primary key
#  artist_id  :integer
#  tag_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe ArtistsTags do
  before { @artists_tag = FactoryGirl.create(:artists_tag) }

  subject { @artists_tag }

  it { should respond_to(:artist_id) }
  it { should respond_to(:tag_id) }
  it { should be_valid }

  it { should belong_to(:artist) }
  it { should belong_to(:tag) }
end
