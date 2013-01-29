class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :task
      t.text :code

      t.timestamps
    end
  end
end
