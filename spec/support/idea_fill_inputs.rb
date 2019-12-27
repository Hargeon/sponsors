RSpec.shared_examples 'idea fill inputs' do
  describe 'fill inputs' do
    let(:amount) { -1 }

    feature 'with correct params' do
      scenario 'should redirect to show' do
        click_button 'commit'
        idea = Idea.first
        expect(page).to have_current_path(idea_path(idea))
      end
    end

    feature 'with incorrect name' do
      scenario 'should display name error' do
        fill_in 'Name', with: ''
        click_button 'commit'
        expect(page).to have_content('Name is too short (minimum is 4 characters)')
      end
    end

    feature 'with incorrect description' do
      scenario 'should display description error' do
        fill_in 'Description', with: ''
        click_button 'commit'
        expect(page).to have_content('Description description need has at least 10 words')
      end
    end

    feature 'without members' do
      scenario 'should display member error' do
        click_button Member.first.name
        click_button 'commit'
        expect(page).to have_content("Local members can't be blank")
      end
    end

    feature 'with incorrect amount of members' do
      scenario 'should display amount error' do
        fill_in 'idea[local_members_attributes][][amount]', with: amount
        click_button 'commit'
        expect(page).to have_content('Local members amount must be greater than or equal to 0')
      end
    end

    feature 'without industries' do
      scenario 'should display local industry error' do
        unselect 'Some name', from: 'idea_local_industries'
        click_button 'commit'
        expect(page).to have_content("Local industries can't be blank")
      end
    end

    feature 'without districts' do
      scenario 'should display local district error' do
        unselect 'Some name', from: 'idea_local_districts'
        click_button 'commit'
        expect(page).to have_content("Local districts can't be blank")
      end
    end

    feature 'without require helps' do
      scenario 'should display local require help error' do
        unselect 'Some name', from: 'idea_local_require_helps'
        click_button 'commit'
        expect(page).to have_content("Local require helps can't be blank")
      end
    end
  end
end
