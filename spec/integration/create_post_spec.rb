require 'rails_helper'

RSpec.feature 'Create Post', type: :feature do
  before :each do
    user = User.create!(first_name: 'User', last_name: 'Name', email: 'example@example.com', password: 'password',
                        password_confirmation: 'password')
    event = user.posts.build(content: 'Test post')
    event.save
    visit new_user_session_path
    page.fill_in 'Email', with: 'example@example.com'
    page.fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  scenario 'Post creation', type: :feature do
    expect(page).to have_text 'Signed in successfully.'
    page.fill_in 'Content', with: 'Test post'
    click_button 'Post'
    expect(page).to have_text 'Post created successfully!'
  end
end
