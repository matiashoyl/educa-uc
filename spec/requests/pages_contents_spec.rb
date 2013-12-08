require 'spec_helper'

describe "PagesContents" do
  
  describe "GET /evaluations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get evaluations_path
      response.status.should be(200)
    end
  end

  describe "Evaluations" do
    it "should have the content 'Evaluaciones'" do
      visit '/evaluations'
      expect(page).to have_content('Evaluaciones')
    end

	it "should have the right title" do
	  visit '/evaluations'
	  expect(page).to have_title("EducaUC Inicial")
	end
  end

  describe "Schools" do
    it "should have the content 'Establecimientos'" do
      visit '/schools'
      expect(page).to have_content('Establecimientos')
    end

    it "should have the right title" do
	  visit '/schools'
	  expect(page).to have_title("EducaUC Inicial")
	end
  end

  describe "Statistics" do
    it "should have the content 'Estadisticas'" do
      visit '/statistics'
      expect(page).to have_content('Estadisticas')
    end

    it "should have the right title" do
	  visit '/statistics'
	  expect(page).to have_title("EducaUC Inicial")
	end
  end

  describe "Users" do
    it "should have the content 'Users'" do
      visit '/users'
      expect(page).to have_content('Users')
    end

    it "should have the right title" do
	  visit '/users'
	  expect(page).to have_title("EducaUC Inicial")
	end
  end

end
