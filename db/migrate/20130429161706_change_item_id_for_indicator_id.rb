class ChangeItemIdForIndicatorId < ActiveRecord::Migration
  def up
  	rename_column :scores, :item_id, :indicator_id
  end

  def down
  end
end
