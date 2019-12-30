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
        fill_and_expect_content('Name is too short (minimum is 4 characters)', 'Name')
      end
    end

    feature 'with incorrect description' do
      scenario 'should display description error' do
        fill_and_expect_content('Description description need has at least 10 words', 'Description')
      end
    end

    feature 'without members' do
      scenario 'should display member error' do
        click_button Member.first.name
        expect_content("Local members can't be blank")
      end
    end

    feature 'with incorrect amount of members' do
      scenario 'should display amount error' do
        fill_and_expect_content('Local members amount must be greater than or equal to 0',
                                'idea[local_members_attributes][][amount]', amount)
      end
    end

    feature 'without industries' do
      scenario 'should display local industry error' do
        unselect_and_expect_content("Local industries can't be blank", 'idea_local_industries')
      end
    end

    feature 'without districts' do
      scenario 'should display local district error' do
        unselect_and_expect_content("Local districts can't be blank", 'idea_local_districts')
      end
    end

    feature 'without require helps' do
      scenario 'should display local require help error' do
        unselect_and_expect_content("Local require helps can't be blank", 'idea_local_require_helps')
      end
    end
  end
end
