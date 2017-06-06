require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create :question }

  describe 'POST #create' do
    sign_in_user
    let(:params) { { answer: attributes_for(:answer), question_id: question, format: :js } }
    let(:invalid_params) { { answer: attributes_for(:invalid_answer), question_id: question, format: :js } }

    context 'with valid attributes' do
      it 'saves new answer in database' do
        expect { post :create, params: params }.to change(question.answers, :count).by(1)
      end
      it 'associates new answer with user' do
        expect { post :create, params: params }.to change(@user.answers, :count).by(1)
      end
      it 'render template create' do
        post :create, params: params
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: invalid_params }.to_not change(Answer, :count)
      end
      it 'render template create' do
        post :create, params: invalid_params
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer_user) { create(:answer, question: question, user: @user) }
    let!(:answer) { create(:answer, question: question) }

    context 'author deletes answer' do
      it 'deletes answer' do
        expect { delete :destroy, params: { id: answer_user } }.to change(Answer, :count).by(-1)
      end
      it 'redirects to question' do
        delete :destroy, params: { id: answer_user }
        expect(response).to redirect_to answer_user.question
      end
    end

    context 'non-author tries to delete question' do
      it 'deletes answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end
      it 'redirects to question' do
        delete :destroy, params: { id: answer_user }
        expect(response).to redirect_to answer.question
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let(:answer_user) { create(:answer, question: question, user: @user) }
    let(:answer) { create(:answer, question: question) }

    context 'author edit his answer ' do
      it 'assigns the requested answer to @answer' do
        patch :update, params: { id: answer_user, answer: attributes_for(:answer), question_id: question, format: :js }
        expect(assigns(:answer)).to eq answer_user
      end
      it 'assigns question to @question' do
        patch :update, params: { id: answer_user, answer: attributes_for(:answer), question_id: question, format: :js }
        expect(assigns(:question)).to eq question
      end
      it 'change answer attributes' do
        patch :update, params: { id: answer_user, answer: { body: 'new_body' }, question_id: question, format: :js }
        answer_user.reload
        expect(answer_user.body).to eq 'new_body'
      end
      it 'render update template' do
        patch :update, params: { id: answer_user, answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :update
      end
    end

    context 'non author edit answer' do
      it 'not change answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new_body' }, question_id: question, format: :js }
        answer.reload
        expect(answer.body).to_not eq 'new_body'
      end
    end
  end
end
