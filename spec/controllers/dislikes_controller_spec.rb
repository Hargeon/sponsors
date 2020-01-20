require 'rails_helper'

RSpec.describe Api::V1::DislikesController, type: :controller do
  let(:idea) { create(:idea) }
  let(:sponsor) { create(:sponsor) }

  describe 'Sponsor authorized' do
    before do
      sign_in sponsor
    end

    context 'POST' do
      context 'without like' do
        let(:expected) {
          {
            'message': 'success',
            'dislike_count': 1,
            'like_count': 0,
            'id': Dislike.last.id,
            'like': false
          }.to_json
        }

        before do
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should add dislike' do
          expect(idea.dislikes.count).to eq(1)
        end

        it 'valid response body' do
          expect(response.body).to eq(expected)
        end

        it_behaves_like 'success action response'
      end

      context 'with like' do
        let(:expected) {
          {
            'message': 'success',
            'dislike_count': 1,
            'like_count': 0,
            'id': Dislike.last.id,
            'like': true
          }.to_json
        }

        before do
          create(:like, idea_id: idea.id, user_id: sponsor.id)
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should add dislike' do
          expect(idea.dislikes.count).to eq(1)
        end

        it 'should remove like' do
          expect(idea.likes.count).to eq(0)
        end

        it 'valid response body' do
          expect(response.body).to eq(expected)
        end

        it_behaves_like 'success action response'
      end
    end

    context 'DELETE' do
      let(:dislike) { create(:dislike, idea_id: idea.id, user_id: sponsor.id) }
      let(:expected) {
        {
          'message': 'success',
          'dislike_count': 0
        }.to_json
      }

      before do
        delete :destroy, xhr: true, params: { id: dislike.id }
      end

      it 'should remove dislike' do
        expect(idea.dislikes.count).to eq(0)
      end

      it 'valid response body' do
        expect(response.body).to eq(expected)
      end

      it_behaves_like 'success action response'
    end
  end

  describe 'Sponsor not authorized' do
    context 'POST' do
      context 'without like' do
        before do
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should not add dislike' do
          expect(idea.dislikes.count).to eq(0)
        end

        it_behaves_like 'unsuccess action json'
        it_behaves_like 'unsuccess action response'
      end

      context 'with like' do
        before do
          create(:like, idea_id: idea.id, user_id: sponsor.id)
          post :create, xhr: true, params: { idea_id: idea.id }
        end

        it 'should not add dislike' do
          expect(idea.dislikes.count).to eq(0)
        end

        it 'should not remove like' do
          expect(idea.likes.count).to eq(1)
        end

        it_behaves_like 'unsuccess action json'
        it_behaves_like 'unsuccess action response'
      end
    end

    context 'DELETE' do
      let(:dislike) { create(:dislike, idea_id: idea.id, user_id: sponsor.id) }

      before do
        delete :destroy, xhr: true, params: { id: dislike.id }
      end

      it 'should not remove dislike' do
        expect(idea.dislikes.count).to eq(1)
      end

      it_behaves_like 'unsuccess action json'
      it_behaves_like 'unsuccess action response'
    end
  end
end
