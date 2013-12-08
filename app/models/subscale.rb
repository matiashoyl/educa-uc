class Subscale < ActiveRecord::Base
  attr_accessible :name, :scale_id

  has_many :items
  has_many :subscale_evaluations
  belongs_to :scale
end
