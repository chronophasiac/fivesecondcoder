class CreateSplitSchemas < ActiveRecord::Migration
  def change
    create_table :split_schemas do |t|
      t.string :name
      t.string :regex

      t.timestamps
    end
  end
end
