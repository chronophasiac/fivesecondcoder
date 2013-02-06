class AddAnswerToCards < ActiveRecord::Migration
  def change
    add_column :cards, :answer, :text
  end
end
