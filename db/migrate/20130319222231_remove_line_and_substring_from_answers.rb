class RemoveLineAndSubstringFromAnswers < ActiveRecord::Migration
  def up
    remove_column :answers, :line
    remove_column :answers, :substring
  end

  def down
    add_column :answers, :substring, :integer
    add_column :answers, :line, :integer
  end
end
