class CreateSubscaleEvaluations < ActiveRecord::Migration
  def change
    create_table :subscale_evaluations do |t|
      t.integer :evaluation_id
      t.integer :subscale_id
      t.integer :subscale_score

      t.timestamps
    end
  end
end
