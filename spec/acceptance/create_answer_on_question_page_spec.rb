require 'rails_helper'

feature 'Create question', %q{
  In order to create answer for question
  As an authenticated user
  I want to be able to write answer on question page
} do

  given(:user) { create :user }
  given(:question) { create :question }

  scenario 'Authenticated user creates answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Input your answer', with: "answer_body"
    click_on 'Post your answer'

    expect(page).to have_content "answer_body"
  end
end