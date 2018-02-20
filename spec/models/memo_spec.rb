require 'rails_helper'

RSpec.describe Memo, type: :model do
  let(:memo) {build :memo}
  it "has a valid factory" do
    expect(memo).to be_valid
  end
  it "show interest by default" do
    expect(memo.interest).to be true
  end
end
