require 'spec_helper'

describe Indicator do
	before :each do
		@scale = Scale.create!(name: "ITERS-R")
		@subscale = Subscale.create!(name: "Espacio y Mueble", scale_id: @scale.id)
		@item = Item.create!(name: "Espacio Interior", comment: "Buen desempeño", subscale_id: @subscale.id)
		@column = Column.create!(item_id: @item.id, puntuation: 1)
		@indicator = Indicator.new(name: "No hay suficiente espacio interior para niños", indicator_number: "1", column_id: @column.id)
	end
	describe "#new" do
		it "toma tres parámetros y devuelve una instancia de Indicator" do
		    @indicator.should be_an_instance_of Indicator
		end
	end
	describe "#name" do
	    it "debe tener el mismo name que la instancia" do
	        @indicator.name.should eql "No hay suficiente espacio interior para niños"
	    end
	end
	describe "#indicator_number" do
	    it "debe tener el indicator_number correcto" do
	        @indicator.indicator_number.should eql "1"
	    end
	end
	describe "#column_id" do
		it "debe tener el column_id correcto" do
			@indicator.column_id.should eql 1
		end
	end
end
