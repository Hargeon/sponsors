require 'rails_helper'

RSpec.describe BusinessmenController, type: :controller do
  describe 'GET show' do
    it 'response has 200 status' do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response.status).to eq(200)
    end
  end
end
