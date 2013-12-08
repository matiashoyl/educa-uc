class AddRoomToEvaluation < ActiveRecord::Migration
  def change
  	add_column :evaluations, :room, :string
  end
end
