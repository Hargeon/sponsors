require 'rails_helper'

RSpec.describe Api::V1::LikesController, type: :controller do
  let(:idea) { create(:idea) }
  let(:sponsor) { create(:sponsor) }

  describe 'Sponsor authorized' do
    before do
      sign_in sponsor
    end

    context 'POST create' do
      context 'without dislike' do
        before do
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should add like' do
          expect(idea.likes.count).to eq(1)
        end

        it 'valid response body' do
          expected = {
            'message': 'success',
            'dislike_count': 0,
            'like_count': 1,
            'id': Like.last.id,
            'dislike': false
          }.to_json
          expect(response.body).to eq(expected)
        end

        it_behaves_like 'success action response'
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

        it 'valid response body' do
          expected = {
            'message': 'success',
            'dislike_count': 0,
            'like_count': 1,
            'id': Like.last.id,
            'dislike': true
          }.to_json
          expect(response.body).to eq(expected)
        end

        it_behaves_like 'success action response'
      end
    end

    context 'DELETE' do
      let(:like) { Like.create(user_id: sponsor.id, idea_id: idea.id) }

      before do
        delete :destroy, xhr: true, params: { id: like.id }
      end

      it 'should remove like' do
        expect(idea.likes.count).to eq(0)
      end

      it 'valid response body' do
        expected = {
          'message': 'success',
          'like_count': 0
        }.to_json
        expect(response.body).to eq(expected)
      end

      it_behaves_like 'success action response'
    end
  end

  describe 'Sponsor not authorized' do
    context 'Post create' do
      context 'without dislike' do
        before do
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should not add like' do
          expect(idea.likes.count).to eq(0)
        end

        it_behaves_like 'unsuccess action json'
        it_behaves_like 'unsuccess action response'
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

        it_behaves_like 'unsuccess action json'
        it_behaves_like 'unsuccess action response'
      end
    end

    context 'DELETE' do
      let(:like) { Like.create(user_id: sponsor.id, idea_id: idea.id) }

      before do
        delete :destroy, xhr: true, params: { id: like.id }
      end

      it 'should not remove like' do
        expect(idea.likes.count).to eq(1)
      end

      it_behaves_like 'unsuccess action json'
      it_behaves_like 'unsuccess action response'
    end
  end
end
