require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/careers/").to route_to("careers#index")
    end

    it "routes to #new" do
      expect(:get => "/careers/new").to route_to("careers#new")
    end

    it "routes to #create" do
      expect(:post => "/careers").to route_to("careers#create")
    end

  end
end
