require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :title }
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to(:user) }

  describe 'answers_ordered method' do
    let(:question) { create :question, answers: create_list(:answer, 2) }
    let(:answer) { question.answers.first }
    let(:second_answer) { question.answers.second }

    it 'should sort question answers, best first' do
      second_answer.best!
      expect(question.answers_ordered.first).to eq second_answer
    end
  end
end

