require 'spec_helper'

describe Subscale do
	before :each do
		@scale = Scale.create!(name: "ITERS-R")
		@subscale = Subscale.new(name: "Espacio y Mueble", scale_id: @scale.id)
	end
	describe "#new" do
		it "toma dos parámetros y devuelve una instancia de Subscale" do
		    @subscale.should be_an_instance_of Subscale
		end
	end
	describe "#name" do
	    it "debe ser igual al nombre de la instancia" do
	        @subscale.name.should eql "Espacio y Mueble"
	    end
	end
	describe "#scale_id" do
	    it "debe ser igual al id de la instancia @scale" do
	        @subscale.scale_id.should eql 1
	    end
	end
end
