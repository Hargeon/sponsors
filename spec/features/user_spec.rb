require 'rails_helper'

RSpec.describe 'User authorization' do
  describe 'Sign up' do
    before do
      user = build(:user)
      visit new_user_registration_path
      fill_user_data(user)
    end

    scenario 'with correct params' do
      click_button 'Create'
      expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
    end

    scenario 'with uncorrect name' do
      fill_in 'Name', with: ''
      click_button 'Create'
      expect(page).to have_content("Name can't be blank")
    end

    scenario 'with uncorrect email' do
      fill_in 'Email', with: ''
      click_button 'Create'
      expect(page).to have_content("Email can't be blank")
    end

    scenario 'with uncorrect password' do
      fill_in 'Password', with: ''
      click_button 'Create'
      expect(page).to have_content("Password can't be blank")
    end

    scenario 'with uncorrect password confirmation' do
      fill_in 'Password confirmation', with: ''
      click_button 'Create'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario 'with uncorrect age' do
      fill_in 'Age', with: ''
      click_button 'Create'
      expect(page).to have_content("Age can't be blank")
    end

    scenario 'with uncorrect phone' do
      fill_in 'Phone', with: ''
      click_button 'Create'
      expect(page).to have_content("Phone can't be blank")
    end
  end

  describe 'Sign in' do
    before do
      user = create(:user)
      visit '/users/sign_in'
      sign_in_user(user)
    end

    scenario 'with correct params' do
      click_button 'Sign in'
      expect(page).to have_link('Log out')
    end

    scenario 'with uncorrect email' do
      fill_in 'Email', with: ''
      click_button 'Sign in'
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'with uncorrect password' do
      fill_in 'Password', with: ''
      click_button 'Sign in'
      expect(page).to have_content('Invalid Email or password')
    end
  end

  describe 'Edit user' do
    let(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      visit edit_user_edit_path(id: user.id)
    end

    feature 'valid params' do
      feature 'change name' do
        let(:name) { 'qwerqwe' }

        scenario 'should display new name' do
          fill_in('Name', with: name)
          expect(page).to have_content("Name: #{name}")
        end
      end
    end

    feature 'invalid params' do
    end
  end
end
