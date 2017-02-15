require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Test1)
  end

  test "login with invalid information" do
    visit '/users/sign_in'
    fill_in('Email', with: '')
    fill_in('Password', with: '')
    click_on('Log in')
    assert page.has_content?('Invalid Email or password.')
  end

  test "login with valid information" do
    visit '/users/sign_in'
    fill_in('Email', with: @user.email)
    fill_in('Password', with: 'password')
    click_on('Log in')
    assert page.has_content?('Signed in successfully.')
    click_on('Logout')
  end

  test "login from the navbar" do
    visit '/'
    click_on ('Login')
    fill_in('Email', with: @user.email)
    fill_in('Password', with: 'password')
    click_on('Log in')
    assert page.has_content?('Signed in successfully.')
    click_on('Logout')
  end

  test "logout successfully" do
    log_in(@user)
    click_on ('Logout')
    assert page.has_content?('You need to sign in or sign up before continuing.')
  end

  test 'Must signin before viewing post index' do
    visit '/'
    assert page.has_content?('You need to sign in or sign up before continuing.')
  end

  test 'cannot create a new post without logging in' do
    visit new_post_path
    assert page.has_content?('You need to sign in or sign up before continuing.')
  end
end
