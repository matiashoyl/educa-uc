class AddIndicatorNumberToIndicator < ActiveRecord::Migration
  def change
  	add_column :indicators, :indicator_number, :integer
  end
end
