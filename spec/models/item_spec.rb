require 'spec_helper'

describe Item do
	before :each do
		@scale = Scale.create!(name: "ITERS-R")
		@subscale = Subscale.create!(name: "Espacio y Mueble", scale_id: @scale.id)
		@item = Item.new(name: "Espacio Interior", comment: "Buen desempeño", subscale_id: @subscale.id)
	end
	describe "#new" do
		it "toma tres parámetros y devuelve una instancia de Item" do
		    @item.should be_an_instance_of Item
		end
	end
	describe "#name" do
	    it "debe tener el mismo name que la instancia" do
	        @item.name.should eql "Espacio Interior"
	    end
	    it "no debe estar vacio" do
	    	@item.name.should_not eql ""
	    end
	end
	describe "#comment" do
	    it "debe tener el comment correcto" do
	        @item.comment.should eql "Buen desempeño"
	    end
	end
	describe "#subscale_id" do
		it "debe tener el subscale_id correcto" do
			@item.subscale_id.should eql 1
		end
	end
end
