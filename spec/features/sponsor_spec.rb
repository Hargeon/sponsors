require 'rails_helper'

RSpec.describe 'Actions with sponsor' do
  feature 'Show page' do
    let(:user) { create(:user, user_type: :sponsor) }

    before do
      visit sponsor_path(user)
    end

    scenario 'should display name' do
      expect(page).to have_content("Name: #{user.name}")
    end

    scenario 'should display email' do
      expect(page).to have_content("Email: #{user.email}")
    end

    scenario 'should display age' do
      expect(page).to have_content("Age: #{user.age}")
    end

    scenario 'should display phone' do
      expect(page).to have_content("Phone: #{user.phone}")
    end
  end
end
