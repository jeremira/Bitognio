require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:user)    {create :user}
  let(:payment) {create :payment, user: user}

  describe 'GET index' do
    context 'when logged in' do
      before :each { sign_in user }
      it 'respond with success' do
        get :index
        expect(response).to have_http_status :success
      end
    end
    context 'when NOT logged in' do
      it 'redirect to sign-in page' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'GET new' do
    context 'when logged in' do
      before :each { sign_in user }
      it 'respond with success' do
        get :new
        expect(response).to have_http_status :success
      end
    end
    context 'when NOT logged in' do
      it 'redirect to sign-in page' do
        get :new
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe 'POST create' do
    context 'when logged in' do
      before { sign_in user}
      before { StripeMock.start }
      let(:stripe_helper) { StripeMock.create_test_helper }
      let(:stripe_token) { stripe_helper.generate_card_token }
      after { StripeMock.stop }

      it 'create a new Payment record for a valid payment' do
        expect{post :create, params: {amount: 4567, stripeToken: stripe_token }}.to change(Payment, :count).by 1
        expected_record = { from: 'stripe', to: user.id, amount: 4567, user_id: user.id,
                            payment_processed: true, error_message: nil }
        expected_record.keys.each do |key|
          expect(Payment.last[key]).to eq expected_record[key]
        end
      end
      it 'create a new Payment record for a invalid payment' do
        expect{post :create, params: {amount: 0, stripeToken: stripe_token }}.to change(Payment, :count).by 1
        expected_record = { from: 'stripe', to: user.id, amount: 0, user_id: user.id,
                            payment_processed: false, error_message: 'Could not pay : Amount too low' }
        expected_record.keys.each do |key|
          expect(Payment.last[key]).to eq expected_record[key]
        end
      end
      it 'redirect to payments page' do
        post :create, params: {amount: 0, stripeToken: stripe_token }
        expect(response).to redirect_to payments_path
      end
    end
    context 'when NOT logged in' do
      it 'redirect to sign-in page' do
        post :create, params: {stripeToken: 'testToken'}
        expect(response).to redirect_to '/users/sign_in'
      end
      it 'do NOT create a new payment record' do
        post :create, params: {stripeToken: 'testToken'}
        expect{response}.to_not change(Payment, :count)
      end
    end
  end
end
