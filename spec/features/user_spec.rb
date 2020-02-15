require 'rails_helper'

RSpec.describe 'User authorization' do
  shared_examples 'page has correct information' do |message|
    scenario "should display #{message}" do
      click_button 'Update'
      expect(page).to have_content(message)
    end
  end

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
        before do
          fill_in('Name', with: 'qwerqwe')
        end

        include_examples 'page has correct information', 'Name: qwerqwe'
      end

      feature 'change phone' do
        let(:phone) { '+375297899654' }

        before do
          fill_in('Phone', with: '+375297899654')
        end

        include_examples 'page has correct information', 'Phone: +375297899654'
      end

      feature 'change age' do
        before do
          fill_in('Age', with: 27)
        end

        include_examples 'page has correct information', 'Age: 27'
      end

      feature 'change language' do
        before do
          select('ru', from: 'user_locale')
        end

        include_examples 'page has correct information', 'Имя: Some name'
      end
    end

    feature 'invalid params' do
      feature 'change name' do
        let(:name) { 'q' }

        before do
          fill_in('Name', with: name)
        end

        include_examples 'page has correct information', 'Name is too short (minimum is 4 characters)'
      end

      feature 'change phone' do
        let(:phone) { '+369414' }

        before do
          fill_in('Phone', with: phone)
        end

        include_examples 'page has correct information', 'Phone invalid'
      end

      feature 'change age' do
        let(:age) { -1 }

        before do
          fill_in('Age', with: age)
        end

        include_examples 'page has correct information', 'Age must be greater than or equal to 12'
      end
    end
  end
end
