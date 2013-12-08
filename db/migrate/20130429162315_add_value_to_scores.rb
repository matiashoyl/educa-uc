class AddValueToScores < ActiveRecord::Migration
  def change
    add_column :scores, :value, :boolean
  end
end
