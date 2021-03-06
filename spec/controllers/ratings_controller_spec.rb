require 'rails_helper'

RSpec.describe Api::V1::RatingsController, type: :controller do
  let(:idea) { create(:idea) }
  let(:attraction) { 3 }
  let(:strategy) { 4 }
  let(:competitiveness) { 2 }
  let(:finance) { 5 }
  let(:average_rating) do
    (attraction + strategy + competitiveness + finance).to_f / 4
  end

  let(:rating_params) do
    {
      rating: {
        idea_id: idea.id,
        attraction: attraction,
        strategy: strategy,
        competitiveness: competitiveness,
        finance: finance
      }
    }
  end

  shared_examples 'should not add to database' do
    it { expect(Rating.count).to eq(0) }
  end

  describe 'Sponsor authorized' do
    let(:sponsor) { create(:sponsor) }

    before do
      sign_in sponsor
    end

    describe 'Valid params' do
      let(:rating) { Rating.first }
      let(:expected_body) do
        {
          'message': 'success',
          'average_rating': average_rating,
          'count_votes': 1
        }.to_json
      end

      before do
        post :create, xhr: true, params: rating_params
      end

      it 'should add to database' do
        expect(Rating.count).to eq(1)
      end

      it 'has a correct attraction' do
        expect(rating.attraction).to eq(attraction)
      end

      it 'has a correct strategy' do
        expect(rating.strategy).to eq(strategy)
      end

      it 'has a correct competitiveness' do
        expect(rating.competitiveness).to eq(competitiveness)
      end

      it 'has a correct finance' do
        expect(rating.finance).to eq(finance)
      end

      it 'has status code 200' do
        expect(response.status).to eq(200)
      end

      it 'has correct response body' do
        expect(response.body).to eq(expected_body)
      end
    end

    describe 'Invalid params' do
      let(:attraction) { 'a' }
      let(:strategy) { 'b' }
      let(:competitiveness) { 'c' }
      let(:finance) { 'd' }
      let(:rating_params) do
        {
          rating: {
            idea_id: idea.id,
            attraction: attraction,
            competitiveness: competitiveness,
            finance: finance
          }
        }
      end

      let(:expected_body) do
        {
          'message': 'All stars must be clicked'
        }.to_json
      end

      before do
        post :create, xhr: true, params: rating_params
      end

      it 'has a status code 400' do
        expect(response.status).to eq(400)
      end

      it 'has an "All stars must be clicked" response body' do
        expect(response.body).to eq(expected_body)
      end

      it_behaves_like 'should not add to database'
    end
  end

  describe 'Sponsor not authorized' do
    let(:expected_body) do
      {
        'message': 'error'
      }.to_json
    end

    before do
      post :create, xhr: true, params: rating_params
    end

    it 'has a status code 403' do
      expect(response.status).to eq(403)
    end

    it 'has a message error response body' do
      expect(response.body).to eq(expected_body)
    end

    it_behaves_like 'should not add to database'
  end
end
