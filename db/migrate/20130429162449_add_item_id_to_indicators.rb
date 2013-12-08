class AddItemIdToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :item_id, :integer
  end
end
