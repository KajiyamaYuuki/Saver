module LoginModule
  def login(user)
    visit user_session_path
    fill_in "devise-sessions-new-email", with: user.email
    fill_in "devise-sessions-new-password", with: 'password'
    click_button "devise-sessions-new-log_in"
  end
end
