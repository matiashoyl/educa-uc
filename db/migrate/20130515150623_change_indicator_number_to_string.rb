class ChangeIndicatorNumberToString < ActiveRecord::Migration
  def up
  	change_column :indicators, :indicator_number, :string
  end

  def down
  end
end
