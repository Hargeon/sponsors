require 'rails_helper'

RSpec.describe 'Actions with sponsor' do
  let(:idea) { create(:idea) }
  let(:user) { create(:sponsor) }
  let(:message) { 't y u i o k j h b n m k kj h g h' }

  feature 'User not authorized' do
    feature 'Show page' do
      before do
        user.interests.create(idea_id: idea.id, message: message)
        visit sponsor_path(id: user.id)
      end

      it_behaves_like 'user show page' do
        let(:user) { create(:sponsor) }
      end

      feature "'Look' button" do
        before do
          click_button 'Look'
        end

        scenario 'should display idea which like the sponsor' do
          user.interests.each do |interest|
            expect(page).to have_content(interest.idea.name)
          end
        end
      end
    end
  end

  feature 'Sponsor authorized' do
    before do
      login_as(user, scope: :user)
    end

    feature 'Show page' do
      before do
        user.interests.create(idea_id: idea.id, message: message)
        visit sponsor_path(id: user.id)
      end

      scenario 'should display Change search criteria' do
        expect(page).to have_selector(:link_or_button, 'Сhange search criteria')
      end

      feature 'Change search criteria' do
        before do
          click_on 'Сhange search criteria'
          select Industry.first.name, from: 'user_sponsor_industries'
          select RequireHelp.first.name , from: 'user_sponsor_helps'
          select District.first.name, from: 'user_sponsor_districts'
          click_on 'Update'
        end

        scenario 'should display industries' do
          expect(page).to have_content("Industries:\n#{user.industries.first.name}")
        end

        scenario 'should display districts' do
          expect(page).to have_content("Districts:\n#{user.districts.first.name}")
        end

        scenario 'should display helps' do
          expect(page).to have_content("Can help:\n#{user.industries.first.name}")
        end
      end
    end

    feature 'Like and Dislike' do
      before do
        visit idea_path(id: idea.id)
      end

      feature 'Add like without dislike' do
        feature 'Add like' do
          scenario 'should display 1 likes' do
            click_on 'Like'
            expect(page).to have_content('Likes 1')
          end
        end

        feature 'Add and remove like' do
          scenario 'should display 0 likes' do
            click_on 'Like'
            click_on 'Like'
            expect(page).to have_content('Likes 0')
          end
        end
      end

      feature 'Add dislike without like' do
        feature 'Add dislike' do
          scenario 'should display 1 dislikes' do
            click_on 'Dislike'
            expect(page).to have_content('Dislikes 1')
          end
        end

        feature 'Add and remove dislike' do
          scenario 'should display 0 dislikes' do
            click_on 'Dislike'
            click_on 'Dislike'
            expect(page).to have_content('Dislikes 0')
          end
        end
      end

      feature 'Add like with dislike' do
        before do
          click_on 'Dislike'
          click_on 'Like'
        end

        scenario 'should display 1 likes' do
          expect(page).to have_content('Likes 1')
        end

        scenario 'should display 0 dislikes' do
          expect(page).to have_content('Dislikes 0')
        end
      end

      feature 'Add dislike with like' do
        before do
          click_on 'Like'
          click_on 'Dislike'
        end

        scenario 'should display 1 dislikes' do
          expect(page).to have_content('Dislikes 1')
        end

        scenario 'should display 0 likes' do
          expect(page).to have_content('Dislikes 0')
        end
      end
    end
  end
end
