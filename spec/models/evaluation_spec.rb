require 'spec_helper'

describe Evaluation do
	before(:each) do
	usuario = User.create!(:name => "Pruebin Speculo", :email => "pruebin@rspec.com", :password => "speculus", :password_confirmation => "speculus")
	colegio = School.create!(:name => "Colegio Spec", :director => "Speculus Diaz", :created_at_year => 1980)
	scale = Scale.create!(name: "ITERS-R")
	@attr = {
		:user_id => usuario.id,
		:school_id => colegio.id,
		:personal_members_present => 5,
		:number_kids => 20,
		:max_number_kids => 30,
		:evaluation_date => Date.new(2010,2,3),
		:number_kids_disability => 1,
		:physical_disability => true,
		:cognitive_disability => false,
		:social_disability => false,
		:other_disability => "",
		:min_birth_date => Date.new(2008,2,3),
		:max_birth_date => Date.new(2009,2,3),
		:start_time => Time.new(2010, 10, 31, 2, 2, 2, "+02:00"),
		:scale_id => scale.id,
		:room => "II D",
		:total_score => 10
	}
	end

	describe "#new" do
		it "toma 18 parámetros y devuelve una instancia de Evaluation" do
		    Evaluation.new(@attr).should be_an_instance_of Evaluation
		end
		it "debe crear una instancia dandole atributos válidos" do
			Evaluation.create(@attr)
		end
	end

	describe "#user_id" do
		it "debe tener el id de la instancia usuario" do
			evaluation = Evaluation.new(@attr)
		    evaluation.user_id.should eql 1
		end
		it "debe ser invalido sin un id de usuario" do
			evaluation = Evaluation.new(@attr.merge(:user_id => nil))
		    evaluation.should_not be_valid
		end
	end

	describe "#school_id" do
		it "debe tener el id de la instancia colegio" do
		    evaluation = Evaluation.new(@attr)
		    evaluation.school_id.should eql 1
		end
		it "debe ser invalido sin un id de usuario" do
			evaluation = Evaluation.new(@attr.merge(:school_id => nil))
		    evaluation.should_not be_valid
		end
	end

	describe "#personal_members_present" do
		it "debe ser invalido sin un numero de personal" do
			evaluation = Evaluation.new(@attr.merge(:personal_members_present => nil))
		    evaluation.should_not be_valid
		end
		it "debe tener un numero de personal positivo (mayor o igual a cero)" do
			evaluation = Evaluation.new(@attr.merge(:personal_members_present => -1))
		    evaluation.should_not be_valid
		end
	end

	describe "#number_kids" do
		it "debe tener un numero de niños positivo (mayor o igual a cero)" do
			evaluation = Evaluation.new(@attr.merge(:number_kids => -1))
		    evaluation.should_not be_valid
		end
	end

	describe "#max_number_kids" do
		it "debe ser invalido sin un numero maximo de niños" do
			evaluation = Evaluation.new(@attr.merge(:max_number_kids => nil))
		    evaluation.should_not be_valid
		end
		it "debe tener un numero de niños positivo (mayor o igual a cero)" do
			evaluation = Evaluation.new(@attr.merge(:max_number_kids => -1))
		    evaluation.should_not be_valid
		end
	end

	describe "#evaluation_date" do
		it "debe ser invalido sin una fecha de evaluacion" do
			evaluation = Evaluation.new(@attr.merge(:evaluation_date => nil))
		    evaluation.should_not be_valid
		end
		it "debe ser una fecha" do
			evaluation = Evaluation.new(@attr.merge(:evaluation_date => "fecha errónea"))
		    evaluation.should_not be_valid
		end
		it "debe ser una fecha de este siglo" do
			evaluation = Evaluation.new(@attr.merge(:evaluation_date => Date.new(1600,1,1)))
		    evaluation.should_not be_valid
		end
	end

	describe "#number_kids_disability" do
		it "debe ser invalido sin un numero de niños con discapacidad" do
			evaluation = Evaluation.new(@attr.merge(:number_kids_disability => nil))
		    evaluation.should_not be_valid
		end
		it "debe tener un numero de niños con discapacidad positivo (mayor o igual a cero)" do
			evaluation = Evaluation.new(@attr.merge(:number_kids_disability => -1))
		    evaluation.should_not be_valid
		end
		it "el numero de niños con discapacidad no debe exceder al numero de niños total" do
			evaluation = Evaluation.new(@attr.merge(:number_kids_disability => 1000))
		    evaluation.should_not be_valid
		end
	end

	describe "#min_birth_date" do
		it "debe ser invalido sin una fecha de evaluacion" do
			evaluation = Evaluation.new(@attr.merge(:min_birth_date => nil))
		    evaluation.should_not be_valid
		end
		it "debe ser una fecha" do
			evaluation = Evaluation.new(@attr.merge(:min_birth_date => "fecha errónea"))
		    evaluation.should_not be_valid
		end
		it "debe ser una fecha de este siglo" do
			evaluation = Evaluation.new(@attr.merge(:min_birth_date => Date.new(1600,1,1)))
		    evaluation.should_not be_valid
		end
	end

	describe "#max_birth_date" do
		it "debe ser invalido sin una fecha de evaluacion" do
			evaluation = Evaluation.new(@attr.merge(:max_birth_date => nil))
		    evaluation.should_not be_valid
		end
		it "debe ser una fecha" do
			evaluation = Evaluation.new(@attr.merge(:max_birth_date => "fecha errónea"))
		    evaluation.should_not be_valid
		end
		it "debe ser una fecha de este siglo" do
			evaluation = Evaluation.new(@attr.merge(:max_birth_date => Date.new(1600,1,1)))
		    evaluation.should_not be_valid
		end
		it "debe ir despues de la fecha minima" do
			evaluation = Evaluation.new(@attr.merge(:max_birth_date => Date.new(2007,1,1)))
		    evaluation.should_not be_valid
		end
	end

	describe "#start_time" do
		it "debe ser invalido sin una fecha de evaluacion" do
			evaluation = Evaluation.new(@attr.merge(:start_time => nil))
		    evaluation.should_not be_valid
		end
		it "debe ser una fecha" do
			evaluation = Evaluation.new(@attr.merge(:start_time => "fecha errónea"))
		    evaluation.should_not be_valid
		end
		it "debe ser una fecha de este siglo" do
			evaluation = Evaluation.new(@attr.merge(:max_birth_date => Date.new(1600,1,1)))
		    evaluation.should_not be_valid
		end
	end

	describe "#scale_id" do
		it "debe tener el id de la instancia scale" do
		    evaluation = Evaluation.new(@attr)
		    evaluation.scale_id.should eql 1
		end
		it "debe ser invalido sin un id de scale" do
			evaluation = Evaluation.new(@attr.merge(:scale_id => nil))
		    evaluation.should_not be_valid
		end
	end

	describe "#room" do
		it "debe tener el room de la instancia" do
		    evaluation = Evaluation.new(@attr)
		    evaluation.room.should eql "II D"
		end
		it "debe ser invalido sin un room" do
			evaluation = Evaluation.new(@attr.merge(:room => nil))
		    evaluation.should_not be_valid
		end
	end

	describe "#total_score" do
		it "debe ser invalido sin un numero de personal" do
			evaluation = Evaluation.new(@attr.merge(:total_score => nil))
		    evaluation.should_not be_valid
		end
		it "debe tener un numero de personal positivo (mayor o igual a cero)" do
			evaluation = Evaluation.new(@attr.merge(:total_score => -1))
		    evaluation.should_not be_valid
		end
	end
end
