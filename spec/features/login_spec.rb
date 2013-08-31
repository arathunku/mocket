require 'spec_helper'
include GoogleAuthInformation

feature 'Sign in via GooglE account' do
  before do
    OmniAuth.config.test_mode = true
    visit "/"
  end

  scenario 'click login via google_oauth2 with valid credit' do
    OmniAuth.config.mock_auth[:google_oauth2] = auth_hash
    expect(page).to have_content "Log in"
    visit '/login'
    expect(page).to have_content "Logout"
  end

  scenario 'invalid creditionals' do
    OmniAuth.config.mock_auth[:google_oauth2] =:invalid_credentials
    visit '/login'
    expect(page).to have_content 'invalid'
  end

  scenario 'click login via google_oauth2 with valid credit && logout' do
    OmniAuth.config.mock_auth[:google_oauth2] = auth_hash
    visit '/login'
    expect(page).to have_content "Logout"
    visit '/logout'
    expect(page).to have_content "Log in"
  end

end