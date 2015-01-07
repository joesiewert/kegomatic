module ObjectCreationMethods

  def create_user(overrides = {})
    User.create!({
      username: Faker::Internet.user_name,
      password: Faker::Internet.password
    }.merge(overrides)
    )
  end

  def signin(user)
    visit signin_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

end
