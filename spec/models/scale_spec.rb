require 'spec_helper'

describe Scale do
	before :each do
		@scale_iters = Scale.new(name: "ITERS-R")
		@scale_ecers = Scale.new(name: "ECERS-R")
	end
	describe "#new" do
		it "toma un parámetros y devuelve una instancia de Scale del tipo iters" do
		    @scale_iters.should be_an_instance_of Scale
		end
		it "toma un parámetros y devuelve una instancia de Scale del tipo iters" do
		    @scale_ecers.should be_an_instance_of Scale
		end
	end
	describe "#name" do
	    it "el nombre debe ser ITERS-R" do
	        @scale_iters.name.should eql "ITERS-R"
	    end
	    it "el nombre debe ser ECERS-R" do
	        @scale_ecers.name.should eql "ECERS-R"
	    end
	end
end
