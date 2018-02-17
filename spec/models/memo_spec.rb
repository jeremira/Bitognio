require 'rails_helper'

RSpec.describe Memo, type: :model do
  let(:postit) {build :postit}
  it "has a valid factory" do
    expect(postit).to be_valid
  end
end
