require_relative 'acceptance_helper'

feature 'Remove files from answer', %q{
  In order to edit my question files
  As an question author
  I want to be able to delete files
} do
  given(:user) { create :user }
  given(:file) { File.open("#{Rails.root}/spec/spec_helper.rb") }
  given(:question) { create :question, user: user }
  before do
    sign_in(user)
    question.attachments.create(file: file)
    visit question_path(question)
  end

  scenario 'Author deletes file', js: true do
    within '.question' do
      click_on 'Delete file'
      expect(page).to_not have_link 'spec_helper.rb'
    end
  end
end