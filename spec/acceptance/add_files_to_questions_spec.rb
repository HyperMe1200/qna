require_relative 'acceptance_helper'

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

  scenario 'User add files when ask question', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'

    click_on 'Upload file'
    within page.all('.nested-fields')[0] do
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    end

    click_on 'Upload file'
    within page.all('.nested-fields')[1] do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end

    click_on 'Create'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
  end
end