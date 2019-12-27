module IdeaHelper
  def fill_idea(idea)
    fill_in 'Name', with: idea.name
    fill_in 'Description', with: idea.description
    fill_in 'Plan', with: idea.plan
    click_on_select
  end

  def click_on_select
    select 'Some name', from: 'idea_local_industries'
    select 'Some name', from: 'idea_local_districts'
    select 'Some name', from: 'idea_local_require_helps'
    click_button Member.first.name
    fill_in 'idea[local_members_attributes][][amount]', with: '2'
  end

  def create_associations_informations
    industry = create(:industry)
    district = create(:district)
    require_help = create(:require_help)
    member = create(:member)
  end
end
