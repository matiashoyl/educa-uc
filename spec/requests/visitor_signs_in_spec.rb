require 'spec_helper'

feature 'Visitor signs in' do
  scenario 'with valid email and password' do
    sign_in_with 'admin@educauc.cl', 'adminuser'

    expect(page).to have_content('Establecimientos')
  end

  scenario 'with invalid email' do
    sign_in_with 'invalid_email', 'password'

    expect(page).to have_content('Sign in')
  end

  scenario 'with blank password' do
    sign_in_with 'admin@educauc.cl', ''

    expect(page).to have_content('Sign in')
  end

  def sign_in_with(email, password)
    visit '/users/sign_in'
    fill_in 'Email', with: email
    fill_in 'user_password', with: password
    click_button 'Sign in'
  end
end