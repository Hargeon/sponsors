# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Actions with idea' do
  describe 'Add idea' do
    before do
      user = create(:user)
      idea = build(:idea)
      login_as(user, scope: :user)
      create_associations_informations
      visit '/ideas/new'
      fill_idea(idea)
    end

    it_behaves_like 'idea example'

    describe 'Edit Idea' do
      before do
        click_button 'Create Idea'
        idea = Idea.first
        visit "/ideas/#{idea.id}/edit"
      end

      it_behaves_like 'idea example'
    end
  end
end
