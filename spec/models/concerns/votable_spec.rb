require 'rails_helper'

RSpec.shared_examples 'votable' do
  it { should have_many(:votes) }

  votable_klass = described_class.to_s.underscore.to_sym
  let(:votable) { create(votable_klass) }
  let(:users) { create_list(:user, 2) }

  describe '#rating' do
    it 'should sum votable votes' do
      votable.vote(users[0], 'up')
      votable.vote(users[1], 'up')
      expect(votable.rating).to eq 2
    end
  end

  describe '#vote' do
    it 'should increase votable rating with "up" arg' do
      votable.vote(users[0], 'up')
      expect(votable.rating).to eq 1
    end
    it 'should discrease votable rating with "down" arg' do
      votable.vote(users[0], 'down')
      expect(votable.rating).to eq -1
    end
  end

  describe '#cancel_vote' do
    it 'should cancel user vote' do
      votable.vote(users[0], 'up')
      votable.cancel_vote(users[0])
      expect(votable.rating).to eq 0
    end
  end

  describe '#already_voted?' do
    it 'should return true if user already voted' do
      votable.vote(users[0], 'up')
      expect(votable.already_voted?(users[0])).to be true
    end
    it 'should return false if user not voted' do
      expect(votable.already_voted?(users[0])).to be false
    end
  end
end