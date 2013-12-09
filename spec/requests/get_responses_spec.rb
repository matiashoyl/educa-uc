require 'spec_helper'

describe "Get Responses" do
  
  describe "GET /evaluations" do
    it "works with a signed in user" do
      sign_in_as_a_valid_user
      get evaluations_path
      response.status.should be(200)
    end

    it "does not work without a signed in user" do
      get evaluations_path
      response.status.should be(302)
    end
  end

  describe "GET /schools" do
    it "works with a signed in user" do
      sign_in_as_a_valid_user
      get schools_path
      response.status.should be(200)
    end

    it "does not work without a signed in user" do
      get schools_path
      response.status.should be(302)
    end
  end

  describe "GET /root" do
    it "works with a signed in user" do
      sign_in_as_a_valid_user
      get evaluations_path
      response.status.should be(200)
    end

    it "does not work without a signed in user" do
      get evaluations_path
      response.status.should be(302)
    end
  end

end