class AddBestToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :best, :bool, default: false
  end
end
