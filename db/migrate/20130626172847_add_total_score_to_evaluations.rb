class AddTotalScoreToEvaluations < ActiveRecord::Migration
  def change
  	add_column :evaluations, :total_score, :integer
  end
end
