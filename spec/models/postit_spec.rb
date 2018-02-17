require 'rails_helper'

RSpec.describe Postit, type: :model do
  let(:memo) {build :memo}
  it "has a valid factory" do
    expect(memo).to be_valid
  end
end
