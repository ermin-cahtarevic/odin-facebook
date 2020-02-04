require 'rails_helper'

RSpec.feature 'Create Comment', type: :feature do
  before :each do
    user = User.create!(first_name: 'User', last_name: 'Name', email: 'example@example.com', password: 'password',
                        password_confirmation: 'password')
    post = user.posts.build(content: 'Test post')
    post.save
    visit new_user_session_path
    page.fill_in 'Email', with: 'example@example.com'
    page.fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  scenario 'Comment creation', type: :feature do
    expect(page).to have_text 'Signed in successfully.'
    page.fill_in 'Comment', with: 'Test comment'
    click_button 'Comment'
    expect(page).to have_text 'Comment added'
  end
end