require 'spec_helper'

describe ItemEvaluation do
	before :each do
		@scale = Scale.create!(name: "ITERS-R")
		@subscale = Subscale.create!(name: "Espacio y Mueble", scale_id: @scale.id)
		@item = Item.create!(name: "Espacio Interior", comment: "Buen desempeño", subscale_id: @subscale.id)
		@item_evaluation = ItemEvaluation.new(evaluation_id: 1, item_id: @item.id, item_score: 0)
	end
	describe "#new" do
		it "toma tres parámetros y devuelve una instancia de ItemEvaluation" do
		    @item_evaluation.should be_an_instance_of ItemEvaluation
		end
	end
	describe "#evaluation_id" do
	    it "debe tener el mismo evaluation_id que la instancia" do
	        @item_evaluation.evaluation_id.should eql 1
	    end
	end
	describe "#item_id" do
	    it "debe tener el item_id de la instancia de item" do
	        @item_evaluation.item_id.should eql 1
	    end
	end
	describe "#item_score" do
		it "debe tener el item_score correcto" do
			@item_evaluation.item_score.should eql 0
		end
	end
end
