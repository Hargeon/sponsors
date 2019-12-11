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
        idea: { name: name, description: description, plan: plan,
                local_industries: [industry.id], local_districts: [district.id],
                local_members: [member.id], local_require_helps: [require_help.id] }
      }
    end

    it 'has a 302 status code' do
      post :create, params: idea_params
      expect(response.status).to eq(302)
    end

    it 'adds to database' do
      post :create, params: idea_params
      expect(Idea.all.size).to eq(1)
    end

    it 'compare name' do
      post :create, params: idea_params
      idea = Idea.first
      expect(idea.name).to eq(name)
    end

    it 'compare plan' do
      post :create, params: idea_params
      idea = Idea.first
      expect(idea.plan).to eq(plan)
    end

    it 'compare description' do
      post :create, params: idea_params
      idea = Idea.first
      expect(idea.description).to eq(description)
    end

    it 'there is industry' do
      post :create, params: idea_params
      industries = Idea.first.industries
      expect(industries).to include(industry)
    end

    it 'there is member' do
      post :create, params: idea_params
      members = Idea.first.members
      expect(members).to include(member)
    end

    it 'there is district' do
      post :create, params: idea_params
      districts = Idea.first.districts
      expect(districts).to include(district)
    end

    it 'there is require help' do
      post :create, params: idea_params
      require_helps = Idea.first.require_helps
      expect(require_helps).to include(require_help)
    end
  end
end
