class AddAtributesToSchool < ActiveRecord::Migration
  def change
  	add_column :schools, :director, :string
  	add_column :schools, :created_at_year, :string
  end
end
