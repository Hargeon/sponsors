require 'rails_helper'

RSpec.describe 'Actions with businessman' do
  feature 'Sponsor not authorized' do
    feature 'Show page' do
      let(:idea) { create(:idea) }
      let(:user) { idea.user }

      before do
        visit businessman_path(user)
      end

      it_behaves_like 'user show page' do
        let(:idea) { create(:idea) }
        let(:user) { idea.user }
      end

      scenario 'should display button for ideas' do
        expect(page).to have_content('Ideas: Look')
      end

      feature "'Look' button" do
        before do
          click_button 'Look'
        end

        scenario 'should dislpay ideas names' do
          user.ideas.each do |idea|
            expect(page).to have_content(idea.name)
          end
        end
      end
    end
  end
end
