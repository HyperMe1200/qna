require 'rails_helper'

feature 'Select best answer', %q{
  As an question author
  I want to be able to select best answer for question
} do
  given(:author) { create :user }
  given(:user) { create :user }
  given(:question) { create :question, user: author, answers: create_list(:answer, 2) }

  scenario 'Author select best answer', js: true do
    sign_in(author)
    visit question_path(question)
    click_link('Mark as best', match: :first)

    expect(page).to have_link 'Mark as best'
    expect(page).to have_content 'Best answer'
  end
  scenario 'Authenticated user try to select best answer for not his question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Mark as best'
  end
  scenario 'Unauthenticated user try to select best answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Mark as best'
  end
end