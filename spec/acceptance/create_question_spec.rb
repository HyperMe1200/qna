require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do

  given(:user) { create :user }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'
    expect(page).to have_content 'Your question successfully created'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Test body'
  end

  scenario 'Non-authenticated user creates question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'need to sign in'
  end

  scenario 'Authenticated user creates non-valid question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    click_on 'Create'
    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "Title can't be blank"

  end

end