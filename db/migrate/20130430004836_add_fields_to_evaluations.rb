class AddFieldsToEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :personal_members_present, :integer
    add_column :evaluations, :number_kids, :integer
    add_column :evaluations, :max_number_kids, :integer
    add_column :evaluations, :evaluation_date, :date
    add_column :evaluations, :number_kids_disability, :integer
    add_column :evaluations, :physical_disability, :boolean
    add_column :evaluations, :cognitive_disability, :boolean
    add_column :evaluations, :social_disability, :boolean
    add_column :evaluations, :other_disability, :string
    add_column :evaluations, :min_birth_date, :date
    add_column :evaluations, :max_birth_date, :date
    add_column :evaluations, :start_time, :time
    add_column :evaluations, :finish_time, :time
  end
end
