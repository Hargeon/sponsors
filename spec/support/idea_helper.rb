module IdeaHelper
  def fill_idea_inputs(idea)
    fill_in 'Name', with: idea.name
    fill_in 'Description', with: idea.description
    fill_in 'Plan', with: idea.plan
    select_associations_inputs
  end

  def select_associations_inputs
    select 'Some name', from: 'idea_local_industries'
    select 'Some name', from: 'idea_local_districts'
    select 'Some name', from: 'idea_local_require_helps'
    click_button Member.first.name
    fill_in 'idea[local_members_attributes][][amount]', with: '2'
  end

  def create_associations_informations
    create(:industry)
    create(:district)
    create(:require_help)
    create(:member)
  end
end
