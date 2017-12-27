require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) {build :account}
  it "has a valid factory" do
    expect(account).to be_valid
  end
  it "has a default balance value" do
    expect(account.balance).to eq 0
  end
  it "require a balance" do
    account.balance = nil
    expect(account).to_not be_valid
  end

  describe "update_balance" do
    it "add an amount to total balance" do
      expect(account.balance).to eq 0
      account.update_balance 1234
      expect(account.balance).to eq 1234
    end
    it "substract an amount to total balance" do
      expect(account.balance).to eq 0
      account.update_balance -2563
      expect(account.balance).to eq -2563
    end
    it "handle a 0 amount" do
      expect(account.balance).to eq 0
      account.update_balance 0
      expect(account.balance).to eq 0
    end
  end
end
