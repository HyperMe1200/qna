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

  def view_question_with_answers
    answers = create_list(:answer, 2, question: question)
    visit question_path(question)

    expect(page).to have_content question.title
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end