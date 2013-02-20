class AddIsRegexToSplitSchemas < ActiveRecord::Migration
  def change
    add_column :split_schemas, :is_regex, :boolean
  end
end
