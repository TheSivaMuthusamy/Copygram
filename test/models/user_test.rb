require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(user_name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.user_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "username should not be too short" do
    @user.user_name = "T"
    assert_not @user.valid?
  end

  test "usernamer should not be too long" do
    @user.user_name = "loooooooooooooooooooooooooooooooooooooooong"
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(caption: "Lorem ipsum", image_file_name: 'image.jpg', image_content_type: 'image/jpeg')
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

  test "associated comments should be destroyed" do
    @user.save
    @user.comments.create!(content: "Lorem ipsum", post_id: 100)
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end

  test "associated notifications should be destroyed" do
    @user.save
    @user.notifications.create!(user_id: @user.id, post_id: 20, subscribed_user_id: 20, identifier: 20, notice_type: "commented")
    assert_difference 'Notification.count', -1 do
      @user.destroy
    end
  end
end
