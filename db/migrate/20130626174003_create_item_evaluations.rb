class CreateItemEvaluations < ActiveRecord::Migration
  def change
    create_table :item_evaluations do |t|
      t.integer :evaluation_id
      t.integer :item_id
      t.integer :item_score

      t.timestamps
    end
  end
end
