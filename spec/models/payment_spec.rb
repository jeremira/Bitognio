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

  describe 'process_stripe_charge' do

    let(:user) {create :user}
    before { StripeMock.start }
    let(:stripe_helper) { StripeMock.create_test_helper }
    after { StripeMock.stop }

    context 'with a valid option hash' do
      let(:valid_option) { {user_id: user.id, amount: 3000, token: stripe_helper.generate_card_token} }
      it 'process stripe payment' do
        expect(Stripe::Charge).to receive(:create)
        Payment.process_stripe_charge(valid_option)
      end
      it 'return a new Payment object' do
        expect(Payment.process_stripe_charge(valid_option)).to be_a_new Payment
      end
      it 'populate a success payment record' do
        new_payment      = Payment.process_stripe_charge(valid_option)
        expect(new_payment.via).to eq 'stripe'
        expect(new_payment.amount).to eq 3000
        expect(new_payment.user_id).to eq user.id
        expect(new_payment.payment_processed).to be true
        expect(new_payment.error_message).to eq nil
      end
    end
    context 'with a invalid option hash' do
      let(:invalid_option) { {user_id: user.id, token: stripe_helper.generate_card_token} }
      it 'process stripe payment' do
        expect(Stripe::Charge).to receive(:create)
        Payment.process_stripe_charge(invalid_option)
      end
      it 'return a new Payment object' do
        expect(Payment.process_stripe_charge(invalid_option)).to be_a_new Payment
      end
      it 'populate a fail payment record' do
        new_payment      = Payment.process_stripe_charge(invalid_option)
        expect(new_payment.via).to eq 'stripe'
        expect(new_payment.amount).to eq 0
        expect(new_payment.user_id).to eq user.id
        expect(new_payment.payment_processed).to be false
        expect(new_payment.error_message).to match /Invalid Argument :/
      end
    end
    context 'Stripe decline charge' do
      before :each { StripeMock.prepare_card_error(:card_declined) }
      let(:decline_opt) { {user_id: user.id, amount: 3000, token: stripe_helper.generate_card_token} }
      it 'process stripe payment' do
        expect(Stripe::Charge).to receive(:create)
        Payment.process_stripe_charge(decline_opt)
      end
      it 'return a new Payment object' do
        expect(Payment.process_stripe_charge(decline_opt)).to be_a_new Payment
      end
      it 'populate a decline payment record' do
        new_payment      = Payment.process_stripe_charge(decline_opt)
        expect(new_payment.via).to eq 'stripe'
        expect(new_payment.amount).to eq 0
        expect(new_payment.user_id).to eq user.id
        expect(new_payment.payment_processed).to be false
        expect(new_payment.error_message).to match /The card was declined/
      end
    end
  end
end
