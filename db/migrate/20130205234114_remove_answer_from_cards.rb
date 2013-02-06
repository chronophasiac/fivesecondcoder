class RemoveAnswerFromCards < ActiveRecord::Migration
  def up
    remove_column :cards, :answer
  end

  def down
    add_column :cards, :answer, :text
  end
end
