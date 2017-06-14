require 'rails_helper'

feature 'Add files to answer', %q{
  In order to ilustrate my answer
  As an answer author
  I want to be able to attach files
} do
  given(:user) { create :user }
  given(:question) { create :question }

  before do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User add file when create answer' do
    fill_in 'Input your answer', with: "answer_body"
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Post your answer'
    attachment = Attachment.last

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: attachment.file.url
    end
  end
end