class RemoveSplitSchemaFromCards < ActiveRecord::Migration
  def up
    remove_column :cards, :split_schema
  end

  def down
    add_column :cards, :split_schema, :string
  end
end
