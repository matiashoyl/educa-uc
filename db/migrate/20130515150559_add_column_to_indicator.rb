class AddColumnToIndicator < ActiveRecord::Migration
  def change
  	add_column :indicators, :column_id, :integer
  	remove_column :indicators, :item_id
  end
end
