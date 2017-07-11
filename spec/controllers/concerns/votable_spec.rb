require 'rails_helper'

shared_examples_for 'votable' do
  votable_klass = described_class.controller_name.singularize.to_sym
  sign_in_user
  let(:votable) { create(votable_klass) }
  let(:author_votable) { create(votable_klass, user: @user) }

  describe 'PATCH #vote_up' do
    context 'user vote up' do
      it 'set rating +1' do
        expect { patch :vote_up, params: { id: votable }, format: :js }.to change(votable, :rating).by(1)
      end
      it 'user cannot vote twice' do
        patch :vote_up, params: { id: votable }, format: :js
        expect { patch :vote_up, params: { id: votable }, format: :js }.to_not change(votable, :rating)
      end
    end

    context 'author vote up' do
      it 'not increase rating' do
        expect { patch :vote_up, params: { id: author_votable }, format: :js }.to_not change(author_votable, :rating)
      end
    end
  end
  describe 'PATCH #vote_down' do
    context 'user vote down' do
      it 'set rating -1' do
        expect { patch :vote_down, params: { id: votable }, format: :js }.to change(votable, :rating).by(-1)
      end
      it 'user cannot vote twice' do
        patch :vote_down, params: { id: votable }, format: :js
        expect { patch :vote_down, params: { id: votable }, format: :js }.to_not change(votable, :rating)
      end
    end

    context 'author vote down' do
      it 'not increase rating' do
        expect { patch :vote_down, params: { id: author_votable }, format: :js }.to_not change(author_votable, :rating)
      end
    end
  end
  describe 'PATCH #cancel_vote' do
    context 'user cancel vote' do
      it 'removes rating changes' do
        patch :vote_down, params: { id: votable }, format: :js
        delete :cancel_vote, params: { id: votable }, format: :js
        votable.reload
        expect(votable.rating).to eq 0
      end
    end
  end
end