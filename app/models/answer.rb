class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments

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
