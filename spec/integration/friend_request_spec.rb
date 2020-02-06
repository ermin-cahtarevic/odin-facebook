require 'rails_helper'

RSpec.feature 'Friend Request', type: :feature do
  before :each do
    @user1 = User.create!(first_name: 'User1', last_name: 'Name', email: 'example1@example.com', password: 'password',
                        password_confirmation: 'password')
    @user2 = User.create!(first_name: 'User2', last_name: 'Name', email: 'example2@example.com', password: 'password',
                        password_confirmation: 'password')
    visit new_user_session_path
    page.fill_in 'Email', with: 'example1@example.com'
    page.fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  scenario 'Sending a friend request', type: :feature do
    expect(page).to have_text 'Signed in successfully.'
    click_link 'Users'
    expect(page).to have_text 'User1 Name'
    expect(page).to have_text 'User2 Name'
    click_link 'Add Friend'
    expect(page).to have_text 'Friend request sent'
    click_link 'Notifications'
    expect(page).to have_text 'Sent friend requests'
    expect(page).to have_text 'User2 Name'
    click_link 'Log out'
    click_link 'Log in'
    page.fill_in 'Email', with: 'example2@example.com'
    page.fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_text 'Signed in successfully.'
    click_link 'Users'
    expect(page).to have_link 'Accept request'
    click_link 'Notifications'
    expect(page).to have_text '1 notification'
    expect(page).to have_link 'Accept request'
    click_link 'Accept request'
    expect(page).to have_text 'Friend request accepted'
    click_link 'Users'
    expect(page).to have_text 'Friend'
  end
end
