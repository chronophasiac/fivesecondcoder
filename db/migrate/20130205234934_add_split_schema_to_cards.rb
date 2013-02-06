class AddSplitSchemaToCards < ActiveRecord::Migration
  def change
    add_column :cards, :split_schema, :string
  end
end
