require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Test1)
    @post = posts(:Post1)
    @opost = posts(:Post2)
    @other = users(:Test2)
  end

  test 'display profile correctly with correct posts' do
    log_in(@user)
    visit '/'
    first('.user-name').click_link @user_name
    assert page.current_path == profile_path(@user.user_name)
    assert page.has_content?(@user.user_name)
    assert page.has_content?(@post.caption)
    assert page.has_no_content?(@opost.caption)
    click_on ('Logout')
  end

  test 'successfully update profile' do
    log_in(@user)
    visit profile_path(@user.user_name)
    click_on ('Edit Profile')
    fill_in('user_bio', with: 'Test')
    attach_file('user_avatar', 'test/fixtures/files/default-avatar.jpg')
    click_on ('Update Profile')
    assert page.has_content?('Your profile has been updated.')
    click_on  ('Logout')
  end

  test 'edit option not available to other users' do
    log_in(@other)
    visit profile_path(@user.user_name)
    assert page.has_no_content?('Edit Profile')
    click_on ('Logout')
  end

end
