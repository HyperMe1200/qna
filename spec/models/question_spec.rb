require 'rails_helper'
require_relative 'concerns/votable_spec.rb'
require_relative 'concerns/attachable_spec.rb'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :title }
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to :user }

  it_behaves_like 'votable'
  it_behaves_like 'attachable'
end

