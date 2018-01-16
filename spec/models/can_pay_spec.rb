require 'rails_helper'

describe CanPay  do
  let(:user)    {create :user}

  describe 'add_money_to_account_balance' do
    it 'add money to account balance' do
      expect(user.account.balance).to eq 0
      user.add_money_to_account_balance 1999
      expect(user.account.balance).to eq 1999
    end
  end

  describe 'remove_money_from_account_balance' do
    it 'remove money from account balance' do
      expect(user.account.balance).to eq 0
      user.remove_money_from_account_balance 1999
      expect(user.account.balance).to eq -1999
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
      it 'return a Payment-builder object' do
        payment_information = user.make_a_payment_with_stripe(3000, valid_token)
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 3000,
                               payment_processed: true, error_message: nil}
        expect(payment_information).to eq expected_stuff
      end
    end

    context 'Invalid amount' do
      it 'do NOT process payment with no amount' do
        expect(Stripe::Charge).to_not receive(:create)
        payment_information = user.make_a_payment_with_stripe(valid_token)
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 0,
                               payment_processed: false, error_message: 'Amount too low'}
        expect(payment_information).to eq expected_stuff
      end
      it 'dont accept amount < 3000' do
        expect(Stripe::Charge).to_not receive(:create)
        payment_information = user.make_a_payment_with_stripe(2999, {token: stripe_helper.generate_card_token})
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 2999,
                               payment_processed: false, error_message: 'Amount too low'}
        expect(payment_information).to eq expected_stuff
      end
      it 'dont accept null amount' do
        expect(Stripe::Charge).to_not receive(:create)
        payment_information = user.make_a_payment_with_stripe(0, {token: stripe_helper.generate_card_token})
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 0,
                               payment_processed: false, error_message: 'Amount too low'}
        expect(payment_information).to eq expected_stuff
      end
    end

    context 'Invalid Stripe params' do
      #before :each { StripeMock.prepare_card_error(:card_declined) }
      it 'dont charge customer' do
        expect(Stripe::Charge).to receive(:create)
        user.make_a_payment_with_stripe(3000)
      end
      it 'return error information' do
        payment_information = user.make_a_payment_with_stripe(3000)
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 3000,
                               payment_processed: false, error_message: 'Internal Error : No token provided'}
        expect(payment_information).to eq expected_stuff
      end
    end

  end
end
