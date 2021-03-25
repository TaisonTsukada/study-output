class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :false_to_true

  def index
    respond_to do |format|
      format.js
    end
  end

  private
  def false_to_true
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

end
