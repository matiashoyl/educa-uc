class CreateSubscales < ActiveRecord::Migration
  def change
    create_table :subscales do |t|
      t.string :name

      t.timestamps
    end
  end
end
