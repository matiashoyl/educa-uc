class AddScaleIdToEvaluation < ActiveRecord::Migration
  def change
  	add_column :evaluations, :scale_id, :integer
  end
end
