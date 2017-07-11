module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def rating
    votes.sum(:value)
  end

  def vote(user, direction)
    value = direction == 'up' ? 1 : -1
    votes.create(user: user, value: value)
  end

  def already_voted?(user)
    Vote.where(user: user, votable: self).exists?
  end

  def cancel_vote(user)
    votes.where(user: user).destroy_all
  end
end
