class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, presence: true
  validates :best, uniqueness: { scope: :question_id }, if: :best

  def best!
    old_best = question.answers.where(best: true)
    transaction do
      old_best.update(best: false)
      update(best: true)
    end
  end
end
