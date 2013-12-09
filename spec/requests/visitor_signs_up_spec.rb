require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'a', 'a@a.cl', '12345678'

    expect(page).to have_content('Evaluaciones')
  end

  scenario 'with invalid email' do
    sign_up_with 'a', 'invalid_email', 'password'

    expect(page).to have_content('Sign up')
  end

  scenario 'with blank password' do
    sign_up_with 'a', 'admin@educauc.cl', ''

    expect(page).to have_content('Sign up')
  end

  def sign_up_with(name, email, password)
    visit '/users/sign_up'
    fill_in 'user_name', with: name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'
  end
end