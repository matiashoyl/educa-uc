class AddSubscaleIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :subscale_id, :integer
  end
end
