module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'Log in'
    expect(current_path).to eq(root_path)
  end
end