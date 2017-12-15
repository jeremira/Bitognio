require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:user)    {create :user}
  let(:payment) {create :payment, user: user}

  describe 'Get Index' do
    context 'when logged in' do
      before :each { sign_in user }
      it 'respond with success' do
        get :index, params: {user_id: user}
        expect(response).to have_http_status :success
      end
    end
    context 'when NOT logged in' do
      it 'redirect to sign-in page' do
        get :index, params: {user_id: user}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST create' do
    context 'when logged in' do
      before :each {sign_in user}
    end
    context 'when NOT logged in' do
      it 'redirect to sign-in page' do
      end
      it 'do NOT create a new payment record' do
      end
    end
  end
end
