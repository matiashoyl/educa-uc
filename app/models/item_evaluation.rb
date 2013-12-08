class ItemEvaluation < ActiveRecord::Base
  attr_accessible :evaluation_id, :item_id, :item_score

  belongs_to :evaluation
  belongs_to :item

end
