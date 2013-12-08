class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.integer :item_id
      t.integer :puntuation

      t.timestamps
    end
  end
end
