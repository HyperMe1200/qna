require_relative 'acceptance_helper'

feature 'Remove files from question', %q{
  In order to edit my answer files
  As an answer author
  I want to be able to delete files
} do
  given(:user) { create :user }
  given(:question) { create :question }
  given(:file) { File.open("#{Rails.root}/spec/spec_helper.rb") }
  given(:answer) { create :answer, user: user, question: question }
  before do
    sign_in(user)
    answer.attachments.create(file: file)
    visit question_path(question)
  end

  scenario 'Author deletes file', js: true do
    within '.answers' do
      click_on 'Delete file'
      expect(page).to_not have_link 'spec_helper.rb'
    end
  end
end