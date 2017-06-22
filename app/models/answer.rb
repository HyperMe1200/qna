class Answer < ApplicationRecord
  include Attachable

  belongs_to :question
  belongs_to :user

  validates :body, :question_id, presence: true
  validates :best, uniqueness: { scope: :question_id }, if: :best

  scope :ordered, -> { order(best: :desc) }

  def best!
    old_best = question.answers.where(best: true)
    transaction do
      old_best.first.update!(best: false) unless old_best.empty?
      update!(best: true)
    end
  end
end
