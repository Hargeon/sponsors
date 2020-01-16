require 'rails_helper'

RSpec.describe 'Actions with businessman' do
  feature 'Show page' do
    let(:idea) { create(:idea) }
    let(:user) { idea.user }

    before do
      visit businessman_path(user)
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
