require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:name) { 'Simple name' }
  let(:description) { 'one two three fout five six seven eight nine ten' }
  let(:plan) { 'one two three fout five six seven eight nine ten' }
  let(:idea) { Idea.create(name: name, description: description, plan: plan) }

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    it 'has a 200 status code' do
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
    it 'has a 200 status code' do
      post :create, params: { idea: { name: name, description: description, plan: plan,
                              local_industries: [1], local_districts: [1], local_members: [1],
                              local_require_helps: [1] } }
      expect(response.status).to eq(200)
    end
  end
end
