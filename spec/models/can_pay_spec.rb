require 'rails_helper'
require 'rspec/expectations'

RSpec::Matchers.define :match_attributes_of do |expected|
  match do |actual|
    expected.keys.each do |key|
      return false if expected[key] != actual[key]
    end
  end
end

describe CanPay  do
  let(:user)    {create :user}
  let(:teacher) {create :user, is_a_teacher: true}
  let(:career)  {build :career, user: teacher}

  describe 'transfer_money_to_teacher' do
    before {StripeMock.start}
    after  {StripeMock.stop}
    context 'student has money' do
      before :each do
        user.account.balance = 10000
        user.save
        teacher
        allow(career).to receive(:create_stripe_connect_account).and_return({id: "acct_testcanpay"})
        career.save
      end

      it 'transfer fund to teacher' do
        expect(career).to receive(:transfer_funds)
        user.transfer_money_to_teacher teacher, 6000
      end
      it 'remove money from user account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(user.account.balance).to eq 4000
      end
      it 'create a new payment record' do
        expect{user.transfer_money_to_teacher teacher, 6000}.to change(Payment, :count).by 1
      end
      it 'return payment information' do
        payment  = user.transfer_money_to_teacher teacher, 6000
        expected_payment = {user_id: user.id, from: 'self', to: teacher.id, amount: 6000,
                               payment_processed: true, error_message: nil}
        expect(payment).to match_attributes_of expected_payment
      end
    end

    context 'student has just enough money' do
      before :each do
        user.account.balance = 6000
        user.save
        teacher
        allow(career).to receive(:create_stripe_connect_account).and_return({id: "acct_testcanpay"})
        career.save
      end
      it 'remove money from student account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(user.account.balance).to eq 0
      end
      it 'transfer fund to teacher' do
        expect(career).to receive(:transfer_funds)
        user.transfer_money_to_teacher teacher, 6000
      end
      it 'create a new payment record' do
        expect{user.transfer_money_to_teacher teacher, 6000}.to change(Payment, :count).by 1
      end
      it 'return payment information' do
        payment = user.transfer_money_to_teacher teacher, 6000
        expected_infos = {user_id: user.id, from: 'self', to: teacher.id, amount: 6000,
                          payment_processed: true, error_message: nil}
        expect(payment).to match_attributes_of expected_infos
      end
    end

    context 'student has not enough money' do
      it 'do NOT remove money from student account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(user.account.balance).to eq 0
      end
      it 'do NOT transfer fund to teacher' do
        expect(career).to_not receive(:transfer_funds)
        user.transfer_money_to_teacher teacher, 6000
      end
      it 'create a new payment record' do
        expect{user.transfer_money_to_teacher teacher, 6000}.to change(Payment, :count).by 1
      end
      it 'return payment information' do
        payment = user.transfer_money_to_teacher teacher, 6000
        expected_infos = {user_id: user.id, from: 'self', to: teacher.id, amount: 6000,
                          payment_processed: false, error_message: 'Not enough money : 0'}
        expect(payment).to match_attributes_of expected_infos
      end
    end
  end

  describe 'make_a_payment_with_stripe' do
    before { StripeMock.start }
    let(:stripe_helper) { StripeMock.create_test_helper }
    let(:valid_token) { {token: stripe_helper.generate_card_token} }
    after { StripeMock.stop }

    context 'Valid Amount and Stripe params' do
      it 'charge customer via Stripe' do
        expect(Stripe::Charge).to receive(:create)
        user.make_a_payment_with_stripe(3000, valid_token)
      end
      it 'create a new payment record' do
        expect{user.make_a_payment_with_stripe(3000, valid_token)}.to change(Payment, :count).by 1
      end
      it 'return a Payment record' do
        payment = user.make_a_payment_with_stripe(3000, valid_token)
        expected_stuff = {user_id: user.id, from: 'stripe', to: user.id, amount: 3000,
                          payment_processed: true, error_message: nil}
        expect(payment).to match_attributes_of expected_stuff
      end
      it 'update the user account balance' do
        user.make_a_payment_with_stripe(5612, valid_token)
        expect(user.account.balance).to eq 5612
      end
    end

    context 'Invalid amount' do
      it 'create a new payment record' do
        expect{user.make_a_payment_with_stripe(nil, valid_token)}.to change(Payment, :count).by 1
        expect{user.make_a_payment_with_stripe(1500, valid_token)}.to change(Payment, :count).by 1
        expect{user.make_a_payment_with_stripe(0, valid_token)}.to change(Payment, :count).by 1
      end
      it 'do NOT process payment with no amount' do
        expect(Stripe::Charge).to_not receive(:create)
        payment = user.make_a_payment_with_stripe(valid_token)
        expected_stuff  = {user_id: user.id, from: 'stripe', to: user.id, amount: 0,
                          payment_processed: false, error_message: 'Could not pay : Amount too low'}
        expect(payment).to match_attributes_of expected_stuff
        expect(user.account.balance).to eq 0
      end
      it 'dont accept amount < 3000' do
        expect(Stripe::Charge).to_not receive(:create)
        payment = user.make_a_payment_with_stripe(2999, {token: stripe_helper.generate_card_token})
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 2999,
                               payment_processed: false, error_message: 'Could not pay : Amount too low'}
        expect(payment).to match_attributes_of expected_stuff
        expect(user.account.balance).to eq 0
      end
      it 'dont accept null amount' do
        expect(Stripe::Charge).to_not receive(:create)
        payment = user.make_a_payment_with_stripe(0, {token: stripe_helper.generate_card_token})
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 0,
                               payment_processed: false, error_message: 'Could not pay : Amount too low'}
        expect(payment).to match_attributes_of expected_stuff
        expect(user.account.balance).to eq 0
      end
    end

    context 'Invalid Stripe params' do
      it 'dont charge customer' do
        expect(Stripe::Charge).to receive(:create)
        user.make_a_payment_with_stripe(3000)
      end
      it 'create a new payment record' do
        expect{user.make_a_payment_with_stripe(4500)}.to change(Payment, :count).by 1
      end
      it 'return error information' do
        payment = user.make_a_payment_with_stripe(3000)
        expected_stuff = {user_id: user.id, from: 'stripe', to: user.id, amount: 3000,
                          payment_processed: false, error_message: 'Could not pay : Token absent or corrupted'}
        expect(payment).to match_attributes_of expected_stuff
      end
      it 'dont change user balance' do
        user.make_a_payment_with_stripe(3000)
        expect(user.account.balance).to eq 0
      end
    end

  end
end
