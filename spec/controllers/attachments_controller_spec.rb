require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  sign_in_user
  let(:question_user) { create(:question, user: @user) }
  let(:question) { create(:question) }
  let(:answer_user) { create(:answer, question: question_user, user: @user) }
  let(:answer) { create(:answer) }

  describe 'DELETE #destroy' do
    before do
      file = File.open("#{Rails.root}/spec/spec_helper.rb")
      question_user.attachments.create(file: file)
      question.attachments.create(file: file)
      answer_user.attachments.create(file: file)
      answer.attachments.create(file: file)
    end
    context 'author deletes attachment' do
      it 'deletes attachment from question' do
        expect { delete :destroy, params: { id: question_user.attachments.last }, format: :js }.to change(Attachment, :count).by(-1)
      end
      it 'deletes attachment from answer' do
        expect { delete :destroy, params: { id: answer_user.attachments.last }, format: :js }.to change(Attachment, :count).by(-1)
      end
    end
    context 'non-author deletes attachment' do
      it 'deletes attachment from question' do
        expect { delete :destroy, params: { id: question.attachments.last }, format: :js }.to_not change(Attachment, :count)
      end
      it 'deletes attachment from answer' do
        expect { delete :destroy, params: { id: answer.attachments.last }, format: :js }.to_not change(Attachment, :count)
      end
    end
  end
end