require 'spec_helper'

describe Column do
	before :each do
		@scale = Scale.create!(name: "ITERS-R")
		@subscale = Subscale.create!(name: "Espacio y Mueble", scale_id: @scale.id)
		@item = Item.create!(name: "Espacio Interior", comment: "Buen desempeño", subscale_id: @subscale.id)
		@column = Column.new(item_id: @item.id, puntuation: 1)
	end
	describe "#new" do
		it "toma dos parámetros y devuelve una instancia de Column" do
		    @column.should be_an_instance_of Column
		end
	end
	describe "#item_id" do
	    it "retorna el numero de item_id correcto" do
	        @column.item_id.should eql 1
	    end
	end
	describe "#puntuation" do
	    it "retorna la puntuacion correcta" do
	        @column.puntuation.should eql 1
	    end
	    it "debe ser una puntuacion mayor a cero" do
	    	@column.puntuation = -1
	    	@column.should_not be_valid
		end
	end
end
