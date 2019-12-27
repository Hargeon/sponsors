# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Actions with idea' do
  describe 'Add idea' do
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

  describe 'Edit Idea' do
    before do
      idea = create(:idea)
      user = idea.user
      login_as(user, scope: :user)
      idea = Idea.first
      visit edit_idea_path(idea)
    end

    it_behaves_like 'idea fill inputs'
  end
end
