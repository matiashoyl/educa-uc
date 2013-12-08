class School < ActiveRecord::Base
   attr_accessible :name, :director, :created_at_year

   has_many :evaluations

   validates :name, :presence => true
   validates :director, :presence => true
   validates :created_at_year, :presence => true, :numericality => true

   def get_average(scale)
   	if scale == 1
   		eval = Evaluation.includes(:school, :scale).where('schools.id = ?', self.id).where('scales.name = ?', 'ITERS-R' )
   	elsif scale == 2
   		eval = Evaluation.includes(:school, :scale).where('schools.id = ?', self.id).where('scales.name = ?', 'ECERS-R' )
   	else 
   		eval = Evaluation.includes(:school, :scale).where('schools.id = ?', self.id)
   	end

   	if eval.count == 0
   		return 0
   	end

   	data = []
   	result = 0
   	eval.each do |evaluation|
   		result += evaluation.get_total_score
   	end
   	data << result / eval.count
   	data
   	
   end
end
