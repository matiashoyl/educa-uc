class SubscaleEvaluation < ActiveRecord::Base
  attr_accessible :evaluation_id, :subscale_id, :subscale_score

  belongs_to :evaluation
  belongs_to :subscale
end
