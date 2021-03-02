class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :false_to_true, only: [:index]

  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
  end

  private

  def false_to_true
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
