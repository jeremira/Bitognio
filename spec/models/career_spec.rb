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
  it "require an iban" do
    career.iban = nil
    expect(career).to_not be_valid
  end

  describe "Career.upgrading_to_teacher_account" do
    before { StripeMock.start }
    after { StripeMock.stop }

    context "with valid data" do
      before do
        fake_account = {id: 'acct_123test'}
        allow(career).to receive(:create_stripe_connect_account).and_return(fake_account)
      end
      it "link a stripe account before to save" do
        expect(career).to receive :upgrading_to_teacher_account
        career.save
      end
      it "update user teacher status" do
        expect(career).to receive :user_become_a_teacher
        career.save
      end
      it "save the career record" do
        expect{career.save}.to change(Career, :count).by 1
      end
      it "link the bank account, the stripe account and the career record together" do
        career.save
        expect(career.connect_account_id).to eq('acct_123test')
      end
      it "save only first 6 digit of the iban" do
        career.save
        expect(career.iban).to eq "FR89370"
      end
      it "flag the user as a teacher" do
        career.save
        expect(career.user.is_a_teacher).to be true
      end
    end
    context "with an invalid zip code" do
      it "do NOT create a new career record" do
        career.zipcode = 00001
        expect{career.save}.to change(Career, :count).by 0
      end
      it "do NOT flag the user as a teacher" do
        career.zipcode = 00001
        career.save
        expect(career.user.is_a_teacher).to be false
      end
    end
    context "with invalid iban" do
      it "do NOT create a new career record" do
        career.iban = "this_is_not_a_valid_iban"
        expect{career.save}.to change(Career, :count).by 0
      end
      it "do NOT flag the user as a teacher" do
        career.iban = "this_is_not_a_valid_iban"
        career.save
        expect(career.user.is_a_teacher).to be false
      end
    end
  end


end
