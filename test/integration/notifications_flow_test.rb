require "test_helper"

class NotificationsFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Test1)
    @other = users(:Test2)
    @post = posts(:Post1)
  end

  test 'User gets notification from index and navbar' do
    log_in(@other)
    click_link("like_#{@post.id}")
    click_on("Logout")
    log_in(@user)
    visit '/notifications'
    assert page.has_css?('.notification-unread-list-container')
    assert page.has_css?('.notification-unread-dropdown-container')
    click_on("Logout")
  end

  test 'User can mark read or unread from index or navbar' do
    log_in(@other)
    click_link("like_#{@post.id}")
    click_on("Logout")
    log_in(@user)
    visit '/notifications'
    click_link('mark')
    assert page.has_no_css?('.notification-unread-list-container')
    click_link('mark_small')
    assert page.has_css?('.notification-unread-dropdown-container')
    click_on("Logout")
  end

  test 'User can use mark read all' do
    log_in(@other)
    click_link("like_#{@post.id}")
    click_on("Logout")
    log_in(@user)
    visit '/notifications'
    click_link('Mark All Read', match: :first)
    assert page.has_no_css?('.notification-unread-list-container')
    click_on("Logout")
  end
end
