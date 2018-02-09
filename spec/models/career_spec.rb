require 'rails_helper'

RSpec.describe Career, type: :model do

  let(:career) {build :career}

  it "has a valid factory" do
    expect(career).to be_valid
  end

  it "require a familly name" do
    career.last_name = nil
    expect(career).to_not be_valid
  end
  it "require a first name" do
    career.first_name = nil
    expect(career).to_not be_valid
  end
  it "require a birthdate" do
    career.dob = nil
    expect(career).to_not be_valid
  end
  it "require a country" do
    career.country = nil
    expect(career).to_not be_valid
  end
  it "require a adress" do
    career.adress = nil
    expect(career).to_not be_valid
  end
  it "require a zip code" do
    career.zipcode = nil
    expect(career).to_not be_valid
  end
  it "require a city" do
    career.city = nil
    expect(career).to_not be_valid
  end

  describe "linking a Stripe connect account" do

    it "create a Stipe account" do
      expect(Stripe::Account).to receive :create
      career = create(:career)
      career.create_connect_account
    end

    it "link stripe account before to save the record" do
      career = create(:career, connect_account_id: nil)
      expect(career.connect_account_id).to eq 'babar'
    end
  end


end
