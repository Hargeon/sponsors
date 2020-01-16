RSpec.shared_examples 'user show page' do |user|
  scenario 'should display name' do
    expect(page).to have_content("Name: #{user.name}")
  end

  scenario 'should display email' do
    expect(page).to have_content("Email: #{user.email}")
  end

  scenario 'should display age' do
    expect(page).to have_content("Age: #{user.age}")
  end

  scenario 'should display phone' do
    expect(page).to have_content("Phone: #{user.phone}")
  end
end
