require 'rails_helper'

feature 'User signs up' do
  let(:user) { build :testuser }

  scenario 'with valid data' do
    visit new_user_registration_url
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_content "Hello #{user.username},"
  end

  scenario 'different confirm password' do
    visit new_user_registration_url
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: 'different_password'
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario 'short password' do
    visit new_user_registration_url
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_button 'Sign up'
    expect(page).to have_content 'Password is too short'
  end
end
