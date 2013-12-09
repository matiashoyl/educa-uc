require 'spec_helper'

describe "PagesContents" do

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

  describe "Root" do
    it "should have the content 'Sign in'" do
      visit '/'
      expect(page).to have_content('Sign in')
    end

    it "should have the right title" do
      visit '/'
      expect(page).to have_title("EducaUC Inicial")
    end
  end

  describe "Sign up" do
    it "should have the content 'Sign up'" do
      visit '/users/sign_up'
      expect(page).to have_content('Sign up')
    end

    it "should have the right title" do
      visit '/users/sign_up'
      expect(page).to have_title("EducaUC Inicial")
    end
  end

  describe "Forgot password" do
    it "should have the content 'Forgot your password?'" do
      visit '/users/password/new'
      expect(page).to have_content('Forgot your password?')
    end

    it "should have the right title" do
      visit '/users/password/new'
      expect(page).to have_title("EducaUC Inicial")
    end
  end

end
