require 'rails_helper'

feature 'Edit question', %q{
  In order to fix question
  As an question author
  I want to be able to edit my question
} do

  given(:author) { create :user }
  given(:user) { create :user }
  given(:question) { create :question, user: author }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit question'
  end

  scenario 'Author try to edit question', js: true do
    sign_in(author)
    visit question_path(question)
    click_on 'Edit question'
    within '.question' do
      fill_in 'Question title', with: 'edited question title'
      fill_in 'Question body', with: 'edited question body'

      click_on 'Save'

      expect(page).to_not have_content question.body
      expect(page).to_not have_content question.title
      expect(page).to have_content 'edited question body'
      expect(page).to have_content 'edited question title'
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario 'Authenticated user try to edit not his question' do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Edit question'
    end
  end
end