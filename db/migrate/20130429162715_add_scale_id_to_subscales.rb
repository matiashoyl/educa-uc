class AddScaleIdToSubscales < ActiveRecord::Migration
  def change
    add_column :subscales, :scale_id, :integer
  end
end
