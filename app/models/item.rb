class Item < ActiveRecord::Base
  attr_accessible :comment, :name, :subscale_id

  has_many :columns
  has_many :item_evaluations
  belongs_to :subscale

end
