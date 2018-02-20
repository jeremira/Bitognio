require "rails_helper"

RSpec.describe PostitsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/postits").to route_to("postits#index")
    end

    it "routes to #create" do
      expect(post: "/postits").to route_to("postits#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/postits/1").to route_to("postits#destroy", :id => "1")
    end

  end
end
