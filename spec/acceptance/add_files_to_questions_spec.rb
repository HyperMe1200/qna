require 'rails_helper'

feature 'Add files to question', %q{
  In order to ilustrate my question
  As an question author
  I want to be able to attach files
} do
  given(:user) { create :user}

  before do
    sign_in(:user)
    visit new_question_path
  end

  scenario 'User add file when ask question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    expect(page).to have_content 'spec_helper.rb'
  end
end