require "test_helper"

class LikesFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Test1)
    @post = posts(:Post1)
  end

  test 'can like a post' do
    log_in(@user)
    click_link("like_#{@post.id}")
    assert page.has_css?('.like.glyphicon.glyphicon-heart')
    assert page.has_content?("#{@user.user_name} likes this")
    click_on("Logout")
  end

  test 'can unlike a post' do
    log_in(@user)
    click_link("like_#{@post.id}")
    assert page.has_css?('.like.glyphicon.glyphicon-heart')
    assert page.has_content?("#{@user.user_name} likes this")
    click_link("like_#{@post.id}")
    assert page.has_no_css?('.like.glyphicon.glyphicon-heart')
    assert page.has_no_content?("#{@user.user_name} likes this")
    click_on("Logout")
  end

end
