require 'rails_helper'

RSpec.describe LessonsController, type: :controller do

  let(:user)    {create :user}
  let(:lesson)  {create :lesson}

  describe 'GET index' do
    it_behaves_like "an authenticated action", :index
  end

  describe 'GET new' do
    it_behaves_like "an authenticated action", :new
  end

  describe 'POST create' do
    it_behaves_like "an authenticated action", :new
  end

end
