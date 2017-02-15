require "test_helper"

class CommentsFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Test1)
    @post = posts(:Post1)
    @one = comments(:one)
    @two = comments(:two)
  end

  test 'Comments show up' do
    log_in(@user)
    assert page.has_content?('Lego')
    click_on ('Logout')
  end

  test 'Can create comments' do
    log_in(@user)
    fill_in("comment_content_#{@post.id}", with: "Woop")
    click_button('New Comment', match: :first)
    click_on ('Logout')
  end

  test 'User can delete own comments' do
    log_in(@user)
    click_link ("delete-#{@one.id}")
    assert page.has_no_content?('Lego')
    click_on ('Logout')
  end

  test 'User cant delete other comments' do
    log_in(@user)
    assert page.has_content?('Can\'t Delete')
    assert page.has_no_css?("#delete-#{@two.id}")
    click_on ('Logout')
  end
end
