require 'spec_helper'

describe Score do
	before :each do
		@scale = Scale.create!(name: "ITERS-R")
		@subscale = Subscale.create!(name: "Espacio y Mueble", scale_id: @scale.id)
		@item = Item.create!(name: "Espacio Interior", comment: "Buen desempeño", subscale_id: @subscale.id)
		@column = Column.create!(item_id: @item.id, puntuation: 1)
		@indicator = Indicator.create!(name: "No hay suficiente espacio interior para niños", indicator_number: "1", column_id: @column.id)
		#Evaluacion instanciada!
		@score = Score.new(evaluation_id: 1, indicator_id: @indicator.id, value: true)
	end
	describe "#new" do
		it "toma tres parámetros y devuelve una instancia de Score" do
		    @score.should be_an_instance_of Score
		end
	end
	describe "#evaluation_id" do
	    it "retorna el numero de evaluation_id correcto" do
	        @score.evaluation_id.should eql 1
	    end
	end
	describe "#indicator_id" do
	    it "retorna el indicator_id correcto" do
	        @score.indicator_id.should eql 1
	    end
	end
	describe "#value" do
		it "retorna el valor correcto" do
			@score.value.should eql true
		end
	end
end
