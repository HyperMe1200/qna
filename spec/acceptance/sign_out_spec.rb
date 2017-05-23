require 'rails_helper'

feature 'sign out', %q{
  In order to be able to close session
  As authenticated user
  I want to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Sign out as authenticated user' do
    sign_in(user)
    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully'
  end
end