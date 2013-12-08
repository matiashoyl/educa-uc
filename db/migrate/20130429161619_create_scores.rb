class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :evaluation_id
      t.integer :item_id

      t.timestamps
    end
  end
end
