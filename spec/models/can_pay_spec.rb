require 'rails_helper'

describe CanPay  do
  let(:user)    {create :user}
  let(:teacher) {create :user}

  describe 'transfer_money_to_teacher' do

    context 'student has money' do
      before :each do
        user.account.balance = 10000
        user.save
      end
      it 'remove money from student account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(user.account.balance).to eq 4000
      end
      it 'add money to teacher account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(teacher.account.balance).to eq 6000
      end
      it 'return payment information' do
        payment_infos  = user.transfer_money_to_teacher teacher, 6000
        expected_infos = {user_id: user.id, from: 'self', to: teacher.id, amount: 6000,
                               payment_processed: true, error_message: nil}
        expect(payment_infos).to eq expected_infos
      end
    end

    context 'student has just enough money' do
      before :each do
        user.account.balance = 6000
        user.save
      end
      it 'remove money from student account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(user.account.balance).to eq 0
      end
      it 'add money to teacher account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(teacher.account.balance).to eq 6000
      end
      it 'return payment information' do
        payment_infos  = user.transfer_money_to_teacher teacher, 6000
        expected_infos = {user_id: user.id, from: 'self', to: teacher.id, amount: 6000,
                               payment_processed: true, error_message: nil}
        expect(payment_infos).to eq expected_infos
      end
    end

    context 'student has not enough money' do
      it 'do NOT remove money from student account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(user.account.balance).to eq 0
      end
      it 'do NOT add money to teacher account' do
        user.transfer_money_to_teacher teacher, 6000
        expect(teacher.account.balance).to eq 0
      end
      it 'return payment information' do
        payment_infos  = user.transfer_money_to_teacher teacher, 6000
        expected_infos = {user_id: user.id, from: 'self', to: teacher.id, amount: 6000,
                               payment_processed: false, error_message: 'Not enough money : 0'}
        expect(payment_infos).to eq expected_infos
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
      it 'return a Payment-builder object' do
        payment_information = user.make_a_payment_with_stripe(3000, valid_token)
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 3000,
                               payment_processed: true, error_message: nil}
        expect(payment_information).to eq expected_stuff
      end
      it 'update the user account balance' do
        user.make_a_payment_with_stripe(5612, valid_token)
        expect(user.account.balance).to eq 5612
      end
    end

    context 'Invalid amount' do
      it 'do NOT process payment with no amount' do
        expect(Stripe::Charge).to_not receive(:create)
        payment_information = user.make_a_payment_with_stripe(valid_token)
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 0,
                               payment_processed: false, error_message: 'Amount too low'}
        expect(payment_information).to eq expected_stuff
        expect(user.account.balance).to eq 0
      end
      it 'dont accept amount < 3000' do
        expect(Stripe::Charge).to_not receive(:create)
        payment_information = user.make_a_payment_with_stripe(2999, {token: stripe_helper.generate_card_token})
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 2999,
                               payment_processed: false, error_message: 'Amount too low'}
        expect(payment_information).to eq expected_stuff
        expect(user.account.balance).to eq 0
      end
      it 'dont accept null amount' do
        expect(Stripe::Charge).to_not receive(:create)
        payment_information = user.make_a_payment_with_stripe(0, {token: stripe_helper.generate_card_token})
        expected_stuff      = {user_id: user.id, from: 'stripe', to: user.id, amount: 0,
                               payment_processed: false, error_message: 'Amount too low'}
        expect(payment_information).to eq expected_stuff
        expect(user.account.balance).to eq 0
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
      it 'dont change user balance' do
        user.make_a_payment_with_stripe(3000)
        expect(user.account.balance).to eq 0
      end
    end

  end
end
