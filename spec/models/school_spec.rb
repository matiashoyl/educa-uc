require 'spec_helper'

describe School do
	before :each do
		@school = School.new(
			name: "Colegio Spec", 
			director: "Speculus Diaz", 
			created_at_year: 1995
		)
	end
	describe "#new" do
		it "toma tres parámetros y devuelve una instancia de School" do
		    @school.should be_an_instance_of School
		end
	end
	describe "#name" do
	    it "retorna el nombre correcto" do
	        @school.name.should eql "Colegio Spec"
	    end
	end
	describe "#director" do
	    it "retorna el director correcto" do
	        @school.director.should eql "Speculus Diaz"
	    end
	end
	describe "#created_at_year" do
	    it "retorna el año correcto en que se creó" do
	        @school.created_at_year.should eql 1995
	    end
	end
end



