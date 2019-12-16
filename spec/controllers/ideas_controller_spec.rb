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

  describe 'GET edit' do
    it 'has a 200 status code' do
      idea = create(:idea)
      get :edit, params: { id: idea.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'POST new' do
    let(:name) { 'Simple name' }
    let(:description) { 'one two three fout five six seven eight nine ten' }
    let(:plan) { 'one two three fout five six seven eight nine ten' }
    let(:amount) { 2 }
    let(:industry) { create(:industry) }
    let(:district) { create(:district) }
    let(:member) { create(:member) }
    let(:require_help) { create(:require_help) }
    let(:idea_params) do
      {
        idea: {
          name: name, description: description, plan: plan,
          local_industries: [industry.id], local_districts: [district.id],
          local_members: [member.id], local_require_helps: [require_help.id],
          members: [amount: amount, member_id: member.id]
        }
      }
    end
    let(:idea) { Idea.first }

    before do
      post :create, params: idea_params
    end

    it 'has a 302 status code' do
      expect(response.status).to eq(302)
    end

    it 'adds to database' do
      expect(Idea.count).to eq(1)
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
      expect(idea.industries).to include(industry)
    end

    it 'has a member' do
      expect(idea.members).to include(member)
    end

    it 'has a  district' do
      expect(idea.districts).to include(district)
    end

    it 'has a require help' do
      expect(idea.require_helps).to include(require_help)
    end

    describe 'PATCH update' do
      let(:new_name) { 'Second Simple name' }
      let(:new_description) { 'Second one two three fout five six seven eight nine ten' }
      let(:new_plan) { 'Second one two three fout five six seven eight nine ten' }
      let(:new_amount) { 4 }
      let(:new_industry) { create(:industry, name: 'Second name') }
      let(:new_district) { create(:district, name: 'Second name') }
      let(:new_member) { create(:member, name: 'Second name') }
      let(:new_require_help) { create(:require_help, name: 'Second name') }
      let(:new_idea_params) do
        {
          id: idea.id,
          idea: {
            name: new_name, description: new_description, plan: new_plan,
            local_industries: [new_industry.id], local_districts: [new_district.id],
            local_members: [new_member.id], local_require_helps: [new_require_help.id],
            members: [amount: new_amount, member_id: new_member.id]
          }
        }
      end

      before do
        patch :update, params: new_idea_params
      end

      it 'has a 302 code status' do
        expect(response.status).to eq(302)
      end

      it 'has an entry in database' do
        expect(Idea.count).to eq(1)
      end

      it 'has a new name' do
        expect(Idea.first.name).to eq(new_name)
      end

      it 'has a new plan' do
        expect(Idea.first.plan).to eq(new_plan)
      end

      it 'has a new description' do
        expect(Idea.first.description).to eq(new_description)
      end

      it 'has a new industry' do
        expect(Idea.first.industries).to include(new_industry)
      end

      it 'has a new disctrict' do
        expect(Idea.first.districts).to include(new_district)
      end

      it 'has a new member' do
        expect(Idea.first.members).to include(new_member)
      end

      it 'has a new require help' do
        expect(Idea.first.require_helps).to include(new_require_help)
      end
    end

    describe 'DELETE destroy' do
      before do
        delete :destroy, params: { id: idea.id }
      end
      it 'deletes the idea' do
        expect(Idea.count).to eq(0)
      end

      it 'has a 302 code' do
        expect(response.status).to eq(302)
      end
    end
  end
end
