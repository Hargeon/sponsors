require 'rails_helper'

RSpec.describe 'Add rating' do
  let(:idea) { create(:idea) }
  let(:first_sponsor) { create(:sponsor) }
  let(:second_sponsor) { create(:sponsor) }

  before do
    create(:rating, user_id: first_sponsor.id, idea_id: idea.id)
  end

  feature 'Sponsor authorized' do
    before do
      login_as(second_sponsor, scope: :user)
      visit idea_path(idea)
    end

    feature 'With valid params' do
      before do
        find(:xpath, '/html/body/div/div/div/div[5]/div[2]/div/div[1]/div[4]').click
        find(:xpath, '/html/body/div/div/div/div[5]/div[2]/div/div[2]/div[2]').click
        find(:xpath, '/html/body/div/div/div/div[5]/div[2]/div/div[3]/div[4]').click
        find(:xpath, '/html/body/div/div/div/div[5]/div[2]/div/div[4]/div[2]').click
        click_on 'Share'
      end

      scenario 'should display 3.25 Average rating' do
        expect(page).to have_content('3.25 Average rating')
      end

      scenario 'should display 2 votes' do
        expect(page).to have_content('2 votes')
      end

      scenario 'should display 3 stars' do
        expect(page).to have_xpath('/html/body/div/div/div/div[5]/div[1]/div/div[3]')
      end

      scenario 'should not display 4 stars' do
        expect(page).to have_no_xpath('/html/body/div/div/div/div[5]/div[1]/div/div[4]')
      end
    end

    feature 'With invalid params' do
      before do
        find(:xpath, '/html/body/div/div/div/div[5]/div[2]/div/div[1]/div[4]').click
        click_on 'Share'
      end

      scenario "should display 'All points must be clicked'" do
        sleep 1
        text = page.driver.browser.switch_to.alert.text
        expect(text).to eq('All points must be clicked')
      end
    end
  end

  feature 'Sponsor not authorized' do
    before do
      visit idea_path(idea)
    end

    scenario 'should not display attraction' do
      expect(page.has_no_css?('#attraction')).to eq(true)
    end

    scenario 'should not display strategy' do
      expect(page.has_no_css?('#strategy')).to eq(true)
    end

    scenario 'should not display competitiveness' do
      expect(page.has_no_css?('#competitiveness')).to eq(true)
    end

    scenario 'should not display finance' do
      expect(page.has_no_css?('#finance')).to eq(true)
    end
  end
end
