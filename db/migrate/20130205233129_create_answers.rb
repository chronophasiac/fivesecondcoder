class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :line
      t.integer :substring
      t.integer :card_id

      t.timestamps
    end
  end
end
