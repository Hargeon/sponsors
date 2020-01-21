require 'rails_helper'

RSpec.describe SponsorsController, type: :controller do
  let(:sponsor) { create(:sponsor) }
  let(:industry) { create(:industry) }
  let(:district) { create(:district) }
  let(:require_help) { create(:require_help) }
  let(:sponsor_params) do
    {
      id: sponsor.id,
      user: {
        sponsor_industries_attributes: [{ industry_id: industry.id }],
        sponsor_districts_attributes: [{ district_id: district.id }],
        sponsor_helps_attributes: [{ require_help_id: require_help.id }]
      }
    }
  end

  shared_examples 'GET show' do
    let(:user) { create(:sponsor) }

    it 'response has 200 status code' do
      get :show, params: { id: user.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'Sponsor authorized' do
    before do
      sign_in sponsor
    end

    describe 'GET edit' do
      it 'response has 200 status code' do
        get :edit, params: { id: sponsor.id }
        expect(response.status).to eq(200)
      end
    end

    describe 'PATCH update' do
      before do
        patch :update, params: sponsor_params
      end

      it 'should change sponsor industry' do
        expect(sponsor.industries.first.name).to eq(industry.name)
      end

      it 'should change sponsor district' do
        expect(sponsor.districts.first.name).to eq(district.name)
      end

      it 'should change sponsor help' do
        expect(sponsor.require_helps.first.name).to eq(require_help.name)
      end
    end

    include_examples 'GET show'
  end

  describe 'Sponsor not authorized' do
    describe 'GET edit' do
      it 'response has 302 status code' do
        get :edit, params: { id: sponsor.id }
        expect(response.status).to eq(302)
      end
    end

    describe 'PATCH update' do
      it 'response has 302 status code' do
        patch :update, params: sponsor_params
        expect(response.status).to eq(302)
      end
    end

    include_examples 'GET show'
  end
end
