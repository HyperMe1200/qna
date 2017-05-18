module AcceptanceMacros
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def view_questions(questions)
    visit questions_path
    questions.each do |q|
      expect(page).to have_content q.title
    end
  end
end