require 'rails_helper'

feature 'Add files to question', %q{
  In order to ilustrate my question
  As an question author
  I want to be able to attach files
} do
  given(:user) { create :user }

  before do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User add file when ask question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    attachment = Attachment.last
    expect(page).to have_link 'spec_helper.rb', href: attachment.file.url
  end
end