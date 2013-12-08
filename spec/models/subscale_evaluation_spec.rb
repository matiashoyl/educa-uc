require 'spec_helper'

describe SubscaleEvaluation do
	before :each do
		@scale = Scale.create!(name: "ITERS-R")
		@subscale = Subscale.create!(name: "Espacio y Mueble", scale_id: @scale.id)
		@subscale_evaluation = SubscaleEvaluation.new(evaluation_id: 1, subscale_id: @subscale.id, subscale_score: 6)
	end
	describe "#new" do
		it "toma tres parámetros y devuelve una instancia de SubscaleEvaluation" do
		    @subscale_evaluation.should be_an_instance_of SubscaleEvaluation
		end
	end
	describe "#evaluation_id" do
	    it "debe ser igual al evaluation_id de la instancia" do
	        @subscale_evaluation.evaluation_id.should eql 1
	    end
	end
	describe "#subscale_id" do
	    it "debe ser igual al id de la instancia @subscale" do
	        @subscale_evaluation.subscale_id.should eql 1
	    end
	end
end
