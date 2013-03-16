class AddStartOffsetAndEndOffsetToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :start_offset, :integer
    add_column :answers, :end_offset, :integer
  end
end
