require "test_helper"

class UserSignUpTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    visit '/users/sign_up'
    assert_no_difference 'User.count' do
      fill_in('Email', with: '')
      fill_in('User Name', with: 'incorrect')
      fill_in('Password', with: 'foobar')
      fill_in('Confirm Password', with: 'foobar')
      click_on ('Sign up')
    end

    assert page.has_content?('can\'t be blank')
  end

  test "valid signup information" do
    visit '/users/sign_up'
    assert_difference 'User.count' do
      fill_in('Email', with: 'test@valid.com')
      fill_in('User Name', with: 'correct')
      fill_in('Password', with: 'foobar')
      fill_in('Confirm Password', with: 'foobar')
      click_on ('Sign up')
    end
    assert page.has_content?('Welcome! You have signed up successfully.')
    click_on ('Logout')
  end
end
