require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "routing" do

    it "routes to root page" do
      expect(:get => "/").to route_to("home#index")
    end

    it "routes to #index" do
      expect(:get => "/home/index").to route_to("home#index")
    end

    it "routes to #contact" do
      expect(:post => "/home/contact").to route_to("home#contact")
    end

  end
end
