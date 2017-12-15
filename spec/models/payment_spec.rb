require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:payment) {build :payment}
  it "has a valid factory" do
    expect(payment).to be_valid
  end
  it "require an payment methos" do
    payment.via = nil
    expect(payment).to_not be_valid
  end
  it "require an amount" do
    payment.amount = nil
    expect(payment).to_not be_valid
  end
  it "has an amount > 0" do
    payment.amount = 0
    expect(payment).to_not be_valid
    payment.amount = -1
    expect(payment).to_not be_valid
  end
end
