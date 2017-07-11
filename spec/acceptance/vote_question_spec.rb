require_relative 'acceptance_helper'

feature 'Vote for question', %q{
  In order to offer an opinion
  As an authenticated user
  I want to be able to vote for question
} do
  given(:author) { create :user }
  given(:user) { create :user }
  given!(:question) { create :question, user: author }

  scenario 'User vote up question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on '+'
      expect(page).to have_content '1'
    end
  end

  scenario 'User cannot vote twice', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on '+'
      expect(page).to have_content 'You can vote only once'
    end
  end

  scenario 'User can cancel vote', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on 'Cancel vote'
      expect(page).to have_content '0'
    end
  end

  scenario 'User vote down question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on '-'
      expect(page).to have_content '-1'
    end
  end

  scenario 'Author cannot vote', js: true do
    sign_in(author)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_content '+'
      expect(page).to_not have_content '-'
      expect(page).to_not have_content 'Cancel vote'
    end
  end
end