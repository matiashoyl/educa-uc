class Indicator < ActiveRecord::Base
  attr_accessible :name, :indicator_number, :column_id

  has_one :score
  belongs_to :column
end
