require 'rails_helper'
require_relative 'concerns/votable_spec.rb'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create :question }

  it_behaves_like 'votable'

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }
    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'assignes new answer to question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }
    it 'assigns new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user

    before { get :edit, params: { id: question } }
    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'renders show view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'associates new question with user' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(@user.questions, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end
      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let(:question) { create :question, user: @user }
    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(assigns(:question)).to eq question
      end
      it 'change question attributes' do
        patch :update, params: { id: question, question: { title: 'new_title', body: 'new_body' }, format: :js }
        question.reload
        expect(question.title).to eq 'new_title'
        expect(question.body).to eq 'new_body'
      end

      it 'renders update template' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      let(:title) { question.title }

      before do
        patch :update, params: { id: question, question: { title: 'new_title', body: nil }, format: :js }
      end
      it 'does not change @question attributes' do
        question.reload
        expect(question.title).to eq title
        expect(question.body).to eq 'MyText'
      end
      it 'renders update template' do
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:question_user) { create(:question, user: @user) }
    let!(:question) { create :question }

    context 'author deletes question' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: question_user } }.to change(Question, :count).by(-1)
      end
      it 'redirects to index view' do
        delete :destroy, params: { id: question_user }
        expect(response).to redirect_to questions_path
      end
    end

    context 'non-author tries to delete question' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end
      it 'redirects to index view' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end
  end
end
