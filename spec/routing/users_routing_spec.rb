require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/users/1").to route_to("users#show", id: "1")
    end

    it "routes to #upgrade" do
      expect(:get => "/users/1/upgrade").to route_to("users#upgrade", id: "1")
    end

    it "routes to #upgrade via PUT" do
      expect(:put => "/users/1/upgrade").to route_to("users#teacherupgrade", id: "1")
    end

  end
end
