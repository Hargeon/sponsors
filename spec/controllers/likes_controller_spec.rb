require 'rails_helper'

RSpec.describe Api::V1::LikesController, type: :controller do
  let(:idea) { create(:idea) }
  let(:sponsor) { create(:user, email: 'sponsor@sponsor.com', user_type: 'sponsor') }

  describe 'Sponsor authorized' do
    before do
      sign_in sponsor
    end

    context 'POST create' do
      context 'without dislike' do
        it 'should add like' do
          post :create, xhr: true, params: { idea_id: idea.id }
          expect(idea.likes.count).to eq(1)
        end
      end

      context 'with dislike' do
        before do
          Dislike.create(user_id: sponsor.id, idea_id: idea.id)
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should add like' do
          expect(idea.likes.count).to eq(1)
        end

        it 'should remove dislike' do
          expect(idea.dislikes.count).to eq(0)
        end
      end
    end

    context 'DELETE' do
      let(:like) { Like.create(user_id: sponsor.id, idea_id: idea.id) }

      it 'should remove like' do
        delete :destroy, xhr: true, params: { id: like.id }
        expect(idea.likes.count).to eq(0)
      end
    end
  end

  describe 'Sponsor not authorized' do
    context 'Post create' do
      context 'without dislike' do
        it 'should not add like' do
          post :create, xhr: true, params: { idea_id: idea.id }
          expect(idea.likes.count).to eq(0)
        end
      end

      context 'with dislike' do
        before do
          Dislike.create(user_id: sponsor.id, idea_id: idea.id)
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should not add like' do
          expect(idea.likes.count).to eq(0)
        end

        it 'should not remove dislike' do
          expect(idea.dislikes.count).to eq(1)
        end
      end
    end

    context 'DELETE' do
      let(:like) { Like.create(user_id: sponsor.id, idea_id: idea.id) }

      it 'should not remove like' do
        delete :destroy, xhr: true, params: { id: like.id }
        expect(idea.likes.count).to eq(1)
      end
    end
  end
end
