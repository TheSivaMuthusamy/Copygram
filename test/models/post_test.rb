require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:Test1)
    @post = @user.posts.create(caption: "Lorem ipsum", image_file_name: 'image.jpg',
                                                       image_content_type: 'image/jpeg')
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "caption should be present" do
    @post.caption = " "
    assert_not @post.valid?
  end

  test "user_id should be present" do
    @post.user_id = " "
    assert_not @post.valid?
  end
  
  test "image should be present" do
    @post.image_file_name = " "
    @post.image_content_type = " "
    assert_not @post.valid?
  end

  test "caption should not be too short" do
    @post.caption = "hi"
    assert_not @post.valid?
  end

  test "caption should be more than 300 characters" do
    @post.caption = "a" * 301
    assert_not @post.valid?
  end

  test "associated comments should be destroyed" do
    @post.save
    @post.comments.create!(content: "Lorem ipsum", user_id: @user.id)
    assert_difference 'Comment.count', -1 do
      @post.destroy
    end
  end

  test "associated notifications should be destroyed" do
    @post.save
    @post.notifications.create!(user_id: @user.id, post_id: @post.id,
                                subscribed_user_id: 20, identifier: @post.id,
                                                      notice_type: "commented")
    assert_difference 'Notification.count', -1 do
      @post.destroy
    end
  end
end
