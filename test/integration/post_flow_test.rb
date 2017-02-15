require "test_helper"

class PostFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Test1)
    @other = users(:Test2)
    @one = posts(:Post1)
    @two = posts(:Post2)
    @three = posts(:Post3)
  end

  test 'index lists all posts of self and followed users' do
    log_in(@user)
    assert page.has_content?(@one.caption)
    assert page.has_content?(@two.caption)
    assert page.has_no_content?(@three.caption)
    click_on ('Logout')
  end

  test 'browse lists all posts' do
    log_in(@user)
    click_on ('Browse Posts')
    assert page.has_content?(@one.caption)
    assert page.has_content?(@two.caption)
    assert page.has_content?(@three.caption)
    click_on ('Logout')
  end

  test 'view individual posts successfully' do
    log_in(@user)
    #Typically, I wouldn't use a match, but the post link and like link are
    #similar, and we know that the post link comes first always
    find(:xpath, ".//a[contains(@href,'posts/#{@one.id}')]", match: :first).click
    assert page.current_path == post_path(@one.id)
    assert page.has_content?(@one.caption)
    click_on ('Logout')
  end

  test 'create new post' do
    log_in(@user)
    click_on ('New Post')
    attach_file('post_image', 'test/fixtures/files/default-avatar.jpg')
    fill_in('post_caption', with: 'Test')
    click_on ('Create Post')
    assert page.has_content?('Your post has been created!')
    assert page.has_content?('Test')
    assert page.has_css?("img[src*='default-avatar']")
    click_on ('Logout')
  end

  test 'creating a post needs image' do
    log_in(@user)
    click_on ('New Post')
    fill_in('post_caption', with: 'No Pic')
    click_on ('Create Post')
    assert page.has_content?('Your new post couldn\'t be created! Please check the form.')
    click_on ('Logout')
  end

  test 'can edit successfully if owner' do
    log_in(@user)
    find(:xpath, ".//a[contains(@href,'posts/#{@one.id}')]", match: :first).click
    click_on ('Edit Post')
    fill_in('post_caption', with: 'Test')
    click_on ('Update Post')
    assert page.has_content?('Post updated.')
    assert page.has_content?('Test')
    click_on ('Logout')
  end

  test 'editing post needs attached image' do
    log_in(@user)
    find(:xpath, ".//a[contains(@href,'posts/#{@one.id}')]", match: :first).click
    click_on ('Edit Post')
    attach_file('post_image', 'test/fixtures/files/default-avatar.txt')
    fill_in('post_caption', with: 'Test')
    click_on ('Update Post')
    assert page.has_content?('Update failed. Please check the form.')
    click_on ('Logout')
  end

  test 'unable to edit unowned post' do
    log_in(@user)
    find(:xpath, ".//a[contains(@href,'posts/#{@two.id}')]", match: :first).click
    assert page.has_no_content?('Edit Post')
    visit edit_post_path(@two)
    assert page.current_path == root_path
    click_on ('Logout')
  end

  test 'can delete post' do
    log_in(@user)
    find(:xpath, ".//a[contains(@href,'posts/#{@one.id}')]", match: :first).click
    click_on ('Edit Post')
    click_on ('Delete Post')
    assert page.has_content?('Your post has been deleted.')
    assert page.has_no_content?(@one.caption)
    click_on('Logout')
  end
end
