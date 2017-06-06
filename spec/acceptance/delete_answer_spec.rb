require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  As an answer author
  I want to be able to delete my answers
} do

  given!(:user) { create :user }
  given!(:question) { create :question }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:user_without_question) { create :user }

  scenario 'Delete answer as an non-author' do
    sign_in(user_without_question)
    visit question_path(question)
    expect(page).to_not have_content 'Delete answer'
  end

  scenario 'Delete answer as an author', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete answer'
    expect(page).to_not have_content (answer.body)
  end

  scenario 'Delete answer as an non-authenticated user' do
    visit question_path(question)
    expect(page).to_not have_content 'Delete answer'
  end

end