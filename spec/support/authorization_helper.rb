module AuthorizationHelper
  def fill_user_data(user)
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    fill_in 'Age', with: user.age
    fill_in 'Phone', with: user.phone
  end

  def sign_in_user(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
  end
end
