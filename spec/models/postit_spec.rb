require 'rails_helper'

RSpec.describe Postit, type: :model do
  let(:postit) {build :memo}
  it "has a valid factory" do
    expect(postit).to be_valid
  end
end
