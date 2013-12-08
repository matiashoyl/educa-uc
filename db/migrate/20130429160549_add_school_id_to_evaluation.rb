class AddSchoolIdToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :school_id, :integer
  end
end
