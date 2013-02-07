class AddSplitSchemaIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :split_schema_id, :integer
  end
end
