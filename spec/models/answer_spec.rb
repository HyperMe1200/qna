require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }
  it { should belong_to(:question) }
  it { should belong_to(:user) }

  describe 'best! method' do
    let(:question) { create :question, answers: create_list(:answer, 2) }
    let(:answer) { question.answers.first }
    let(:another_answer) { question.answers.second }
    before do
      answer.best!
    end

    it 'set best answer' do
      answer.reload

      expect(answer.best).to eq true
    end
    it 'cannot set more than one best answer' do
      another_answer.update(best: true)
      another_answer.reload

      expect(another_answer.best).to eq false
    end
    it 'can change best answer' do
      another_answer.best!
      another_answer.reload

      expect(another_answer.best).to eq true
    end
  end
end
