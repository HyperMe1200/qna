require 'rails_helper'

feature 'Show question with answers', %q{
  In order to view question with answers
  As authenticated and non-authenticated user
  I want to be able to view questions and it answers from other users
} do

  given(:question) { create :question }
  given(:user) { create :user }

  scenario 'view question page as authenticated user' do
    sign_in(user)
    view_question_with_answers
  end

  scenario 'view question page as non-authencticated user' do
    view_question_with_answers
  end
end