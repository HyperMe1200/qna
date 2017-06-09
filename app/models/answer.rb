class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, presence: true
  validates_uniqueness_of :best, conditions: -> { where(best: true) }, scope: :question_id

  def best!
    old_best = question.answers.where(best: true)
    old_best.update(best: false)
    update(best: true)
  end
end
