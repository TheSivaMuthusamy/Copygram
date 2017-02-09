class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to post_path @notification.post
  end

  def index
    @notifications = current_user.notifications.order('created_at DESC').page params[:page]
    respond_to do |format|
      format.js
      format.html
    end
  end

  def mark_read
    @notification = Notification.find(params[:id])
    @notification.update read: true
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def mark_unread
    @notification = Notification.find(params[:id])
    @notification.update read: false
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def mark_read_all
    @notifications = current_user.notifications.where(read: false)
    @notifications.update_all read: true
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
