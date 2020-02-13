RSpec.shared_examples 'idea fill inputs' do
  describe 'fill inputs' do
    let(:amount) { -1 }

    shared_examples 'page has correct message' do |message|
      scenario "should display #{message}" do
        #click_button 'commit'
        find(:xpath, '/html/body/div/div/div/form/p[6]/input').click
        expect(page).to have_content(message)
      end
    end

    feature 'with correct params' do
      scenario 'should redirect to show' do
        #click_button 'commit'
        find(:xpath, '/html/body/div/div/div/form/p[6]/input').click
        idea = Idea.first
        expect(page).to have_current_path(idea_path(id: idea.id, locale: 'en'))
      end
    end

    feature 'with incorrect name' do
      before do
        fill_in('Title', with: '')
      end

      include_examples 'page has correct message', 'Title is too short (minimum is 4 characters)'
    end

    feature 'with incorrect description' do
      before do
        fill_in('Description', with: '')
      end

      include_examples 'page has correct message', 'Description need has at least 10 words'
    end

    feature 'without members' do
      before do
        click_button Member.first.name
      end

      include_examples 'page has correct message', "Members can't be blank"
    end

    feature 'with incorrect amount of members' do
      before do
        fill_in 'idea[local_members_attributes][][amount]', with: amount
      end

      include_examples 'page has correct message', "Amount of members can't equal -1"
    end

    feature 'without industries' do
      before do
        unselect 'Some name', from: 'idea_local_industries'
      end

      include_examples 'page has correct message', "Industries can't be blank"
    end

    feature 'without districts' do
      before do
        unselect 'Some name', from: 'idea_local_districts'
      end

      include_examples 'page has correct message', "Districts can't be blank"
    end

    feature 'without require helps' do
      before do
        unselect 'Some name', from: 'idea_local_require_helps'
      end

      include_examples 'page has correct message', "Require help can't be blank"
    end
  end
end
