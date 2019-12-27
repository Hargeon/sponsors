RSpec.shared_examples 'idea example' do
  describe 'uncorrect associations' do
    let(:amount) { -1 }

    scenario 'with correct params' do
      click_button 'commit'
      expect(page).not_to have_button('Create Idea')
    end

    scenario 'with uncorrect name' do
      fill_in 'Name', with: ''
      click_button 'commit'
      expect(page).to have_content('Name is too short (minimum is 4 characters)')
    end

    scenario 'with uncorrect description' do
      fill_in 'Description', with: ''
      click_button 'commit'
      expect(page).to have_content('Description description need has at least 10 words')
    end

    scenario 'without members' do
      click_button Member.first.name
      click_button 'commit'
      expect(page).to have_content("Local members can't be blank")
    end

    scenario 'with uncorrect amount of members' do
      fill_in 'idea[local_members_attributes][][amount]', with: amount
      click_button 'commit'
      expect(page).to have_content('Local members amount must be greater than or equal to 0')
    end

    scenario 'without industries' do
      unselect 'Some name', from: 'idea_local_industries'
      click_button 'commit'
      expect(page).to have_content("Local industries can't be blank")
    end

    scenario 'without districts' do
      unselect 'Some name', from: 'idea_local_districts'
      click_button 'commit'
      expect(page).to have_content("Local districts can't be blank")
    end

    scenario 'without require helps' do
      unselect 'Some name', from: 'idea_local_require_helps'
      click_button 'commit'
      expect(page).to have_content("Local require helps can't be blank")
    end
  end
end
