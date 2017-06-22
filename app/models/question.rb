class Question < ApplicationRecord
  include Attachable
  include Votable

  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :body, :title, presence: true
end
