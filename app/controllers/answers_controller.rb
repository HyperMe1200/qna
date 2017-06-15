class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update, :best]
  before_action :set_answer, only: [:destroy, :update, :best]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'Your answer successfully deleted.'
    else
      flash[:notice] = 'You cannot delete this answer.'
    end
  end

  def update
    if current_user.author_of?(@answer)
      @question = @answer.question
      @answer.update(answer_params)
    else
      flash[:notice] = 'You cannot edit this answer.'
    end
  end

  def best
    if current_user.author_of?(@answer.question)
      @answer.best!
    else
      flash[:notice] = 'You cannot select best answer.'
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
