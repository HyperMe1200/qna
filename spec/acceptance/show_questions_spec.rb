require 'rails_helper'

feature 'Show questions', %q{
  In order to view questions
  As authenticated and non-authenticated user
  I want to be able to view questions from other users
} do

  given(:user) { create :user }
  given(:questions) { create_list(:question, 2) }

  scenario 'Authenticated user view questions' do
    sign_in(user)
    view_questions(questions)
  end

  scenario 'Non-Authenticated user view questions' do
    view_questions(questions)
  end
end