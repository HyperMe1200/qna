class AddAttachmentsToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :attachments, :question, index: true
  end
end
