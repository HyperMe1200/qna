class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :body, :title, presence: true

  # def answers_ordered
  #   answers.order(best: :desc)
  # end
end
