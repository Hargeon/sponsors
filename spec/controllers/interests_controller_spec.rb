require 'rails_helper'

RSpec.describe InterestsController, type: :controller do
  describe 'Sponsor authorized' do
    let(:idea) { create(:idea) }
    let(:sponsor) { create(:user, email: 'sponsor@sponsor.com', user_type: 'sponsor') }
    let(:message) { 'q w e r t y u i o p k hj g f d d' }

    before do
      sign_in sponsor
    end

    context 'POST intersts' do
      it 'should add to database' do
        post :create, xhr: true,  params: { interest: { message: message, idea_id: idea.id } }
        expect(Interest.count).to eq(1)
      end

      it 'should not add to database' do
        message = 'q w e r'
        post :create, xhr: true, params: { interest: { message: message, idea_id: idea.id } }
        expect(Interest.count).to eq(0)
      end
    end
  end

  describe 'Sponsor not authorized' do
    let(:idea) { create(:idea) }
    let(:message) { 'q w e r t y u i o p k hj g f d d' }

    context 'Post interests' do
      it 'should redirect' do
        post :create, xhr: true,  params: { interest: { message: message, idea_id: idea.id } }
        expect(response.status).to eq(302)
      end

      it 'should redirect' do
        message = 'qw we e'
        post :create, xhr: true,  params: { interest: { message: message, idea_id: idea.id } }
        expect(response.status).to eq(302)
      end
    end
  end
end
