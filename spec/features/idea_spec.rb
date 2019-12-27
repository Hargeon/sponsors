# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Actions with idea' do
  describe 'User logged in' do
    feature 'Add idea' do
      before do
        user = create(:user)
        idea = build(:idea)
        login_as(user, scope: :user)
        create_associations_informations
        visit new_idea_path
        fill_idea_inputs(idea)
      end

      it_behaves_like 'idea fill inputs'
    end

    feature 'Edit idea' do
      before do
        idea = create(:idea)
        user = idea.user
        login_as(user, scope: :user)
        visit edit_idea_path(idea)
      end

      it_behaves_like 'idea fill inputs'
    end
  end

  describe 'User not logged in' do
    feature 'Add idea' do
      scenario 'Should be redirect to Sign in' do
        visit new_idea_path
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    feature 'Edit idea' do
      scenario 'Should be redirect to Sign in' do
        idea = create(:idea)
        visit edit_idea_path(idea)
        expect(page).to have_current_path(new_user_session_path)
      end
    end
  end
end
