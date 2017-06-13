class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :attachments

  validates :body, :title, presence: true

  # def answers_ordered
  #   answers.order(best: :desc)
  # end
end
