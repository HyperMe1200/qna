require 'rails_helper'

feature 'Edit answer', %q{
  In order to fix answer
  As an answer author
  I want to be able to edit my answer
} do
  given(:author) { create :user }
  given(:user) { create :user }
  given(:question) { create :question }
  given!(:answer) { create :answer, user: author, question: question }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit answer'
  end

  scenario 'Author try to edit answer', js: true do
    sign_in(author)
    visit question_path(question)
    click_on 'Edit answer'
    within '.answers' do
      fill_in 'Answer', with: 'edited answer body'
      click_on 'Save'

      expect(page).to_not have_content answer.body
      expect(page).to have_content 'edited answer body'
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario 'Authenticated user try to edit not his answer' do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Edit answer'
    end
  end
end

