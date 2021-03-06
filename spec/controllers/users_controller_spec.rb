require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) {create :user}

  describe 'Get Show' do
    context 'when logged in' do
      it 'respond with success' do
        sign_in user
        get :show, params: {id: user}
        expect(response).to have_http_status :success
      end
    end
    context 'when NOT logged in' do
      it 'redirect on sign-in page' do
        get :show, params: {id: user}
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

end
