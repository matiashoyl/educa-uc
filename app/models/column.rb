class Column < ActiveRecord::Base
  attr_accessible :item_id, :puntuation

  belongs_to :item
  has_many :indicators

  validates :item_id, :uniqueness => { :scope => :puntuation }
  validates :puntuation, :numericality => { :greater_than_or_equal_to => 0 }
end
