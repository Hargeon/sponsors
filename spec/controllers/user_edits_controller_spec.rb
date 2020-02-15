require 'rails_helper'

RSpec.describe UserEditsController, type: :controller do
  let(:user) { create(:user) }

  describe 'User authorized' do
    before do
      sign_in user
    end

    describe 'PATCH update' do
      describe 'Valid params' do
        context 'change name' do
          let(:name) { 'New name' }

          it 'should change name' do
            patch :update, params: {
              id: user.id,
              user: {
                name: name
              }
            }

            expect(User.first.name).to eq(name)
          end
        end

        context 'change phone' do
          let(:phone) { '+375291222365' }

          it 'should change phone' do
            patch :update, params: {
              id: user.id,
              user: {
                phone: phone
              }
            }

            expect(User.first.phone).to eq(phone)
          end
        end

        context 'change locale' do
          let(:locale) { 'ru' }

          it 'should change locale' do
            patch :update, params: {
              id: user.id,
              user: {
                locale: locale
              }
            }

            expect(User.first.locale).to eq(locale)
          end
        end

        context 'change age' do
          let(:age) { 27 }

          it 'should change age' do
            patch :update, params: {
              id: user.id,
              user: {
                age: age
              }
            }

            expect(User.first.age).to eq(age)
          end
        end
      end

      describe 'Invalid params' do
        context 'change name' do
          let(:name) { 'q' }

          it 'should not change name' do
            patch :update, params: {
              id: user.id,
              user: {
                name: name
              }
            }

            expect(User.first.name).not_to eq(name)
          end
        end

        context 'change phone' do
          let(:phone) { '+32569' }

          it 'should not change phone' do
            patch :update, params: {
              id: user.id,
              user: {
                phone: phone
              }
            }

            expect(User.first.phone).not_to eq(phone)
          end
        end

        context 'change age' do
          let(:age) { -5 }

          it 'should not change age' do
            patch :update, params: {
              id: user.id,
              user: {
                age: age
              }
            }

            expect(User.first.age).not_to eq(age)
          end
        end
      end
    end

    describe 'GET edit' do
      it 'should has status code 200' do
        get :edit, params: { id: user.id }
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'User not authorized' do
    describe 'GET edit' do
      it 'should has status code 302' do
        get :edit, params: { id: user.id }
        expect(response.status).to eq(302)
      end
    end

    describe 'PATCH update' do
      let(:name) { 'hoionol' }
      let(:phone) { '+375464' }
      let(:locale) { 'ru' }
      let(:age) { 25 }

      before do
        patch :update, params: {
          id: user.id,
          user: {
            name: name,
            phone: phone,
            locale: locale,
            age: age
          }
        }
      end

      it 'should not change name' do
        expect(User.first.name).not_to eq(name)
      end

      it 'should not change phone' do
        expect(User.first.phone).not_to eq(phone)
      end

      it 'should not change locale' do
        expect(User.first.locale).not_to eq(locale)
      end

      it 'should not change age' do
        expect(User.first.age).not_to eq(age)
      end
    end
  end
end
