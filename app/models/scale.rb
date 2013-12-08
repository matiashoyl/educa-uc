class Scale < ActiveRecord::Base
  attr_accessible :name

  has_many :subscales
  has_many :evaluations
end
