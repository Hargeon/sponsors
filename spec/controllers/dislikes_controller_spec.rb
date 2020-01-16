require 'rails_helper'

RSpec.describe Api::V1::DislikesController, type: :controller do
  let(:idea) { create(:idea) }
  let(:sponsor) { create(:user, email: 'sponsor@sponsor.com', user_type: 'sponsor') }

  describe 'Sponsor authorized' do
    before do
      sign_in sponsor
    end

    context 'POST create' do
      context 'without like' do
        it 'should add dislike' do
          post :create, xhr: true, params: { idea_id: idea.id }
          expect(idea.dislikes.count).to eq(1)
        end
      end

      context 'with like' do
        before do
          Like.create(idea_id: idea.id, user_id: sponsor.id)
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should add dislike' do
          expect(idea.dislikes.count).to eq(1)
        end

        it 'should remove like' do
          expect(idea.likes.count).to eq(0)
        end
      end
    end

    context 'DELETE' do
      let(:dislike) { Dislike.create(idea_id: idea.id, user_id: sponsor.id) }

      it 'should remove dislike' do
        delete :destroy, xhr: true, params: { id: dislike.id }
        expect(idea.dislikes.count).to eq(0)
      end
    end
  end

  describe 'Sponsor not authorized' do
    context 'POST create' do
      context 'without like' do
        it 'should not add dislike' do
          post :create, xhr: true, params: { idea_id: idea.id }
          expect(idea.dislikes.count).to eq(0)
        end
      end

      context 'with like' do
        before do
          Like.create(idea_id: idea.id, user_id: sponsor.id)
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should not add dislike' do
          expect(idea.dislikes.count).to eq(0)
        end

        it 'should not remove like' do
          expect(idea.likes.count).to eq(1)
        end
      end
    end

    context 'DELETE' do
      let(:dislike) { Dislike.create(idea_id: idea.id, user_id: sponsor.id) }

      it 'should not remove dislike' do
        delete :destroy, xhr: true, params: { id: dislike.id }
        expect(idea.dislikes.count).to eq(1)
      end
    end
  end
end
