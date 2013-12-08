class Score < ActiveRecord::Base
  attr_accessible :evaluation_id, :indicator_id, :value

  belongs_to :evaluation
  belongs_to :indicator
end
