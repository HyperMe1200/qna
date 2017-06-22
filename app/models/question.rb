class Question < ApplicationRecord
  include Attachable

  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :body, :title, presence: true
end
