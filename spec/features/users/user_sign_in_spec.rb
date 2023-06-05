require 'rails_helper'

feature 'User signs in' do
  let(:user) { create(:user) }

  scenario 'with valid credentials' do
    visit new_user_session_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    check 'Remember me'
    click_button 'Log in'
    expect(page).to have_content "Hello #{user.username},"
  end

  scenario 'with invalid credentials' do
    visit new_user_session_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'invalid_password'
    check 'Remember me'
    click_button 'Log in'
    expect(page).to have_content 'Invalid Username or password.'
  end
end
