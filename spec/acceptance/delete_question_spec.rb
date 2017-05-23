require 'rails_helper'

feature 'Create question', %q{
  In order to delete question
  As an question author
  I want to be able to delete my questions
} do

  given(:user) { create :user }
  given(:question) { create(:question, user: user) }

  scenario 'Delete question as an author' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'
    expect(page).to_not have_content (question.title)
  end
end