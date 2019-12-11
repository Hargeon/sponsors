require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    it 'has a 200 status code' do
      idea = create(:idea)
      get :show, params: { id: idea.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST new' do
    let(:name) { 'Simple name' }
    let(:description) { 'one two three fout five six seven eight nine ten' }
    let(:plan) { 'one two three fout five six seven eight nine ten' }
    let(:industry) { create(:industry) }
    let(:district) { create(:district) }
    let(:member) { create(:member) }
    let(:require_help) { create(:require_help) }
    let(:idea_params) do
      {
        idea: {
          name: name, description: description, plan: plan,
          local_industries: [industry.id], local_districts: [district.id],
          local_members: [member.id], local_require_helps: [require_help.id]
        }
      }
    end
    let(:idea) { Idea.first }

    before(:each) do
      post :create, params: idea_params
    end

    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end

    it 'adds to database' do
      expect(Idea.all.size).to eq(1)
    end

    it 'has a correct name' do
      expect(idea.name).to eq(name)
    end

    it 'has a correct plan' do
      expect(idea.plan).to eq(plan)
    end

    it 'has a correct description' do
      expect(idea.description).to eq(description)
    end

    it 'has an industry' do
      expect(Idea.first.industries).to include(industry)
    end

    it 'has a member' do
      expect(Idea.first.members).to include(member)
    end

    it 'has a  district' do
      expect(Idea.first.districts).to include(district)
    end

    it 'has a require help' do
      expect(Idea.first.require_helps).to include(require_help)
    end
  end
end
