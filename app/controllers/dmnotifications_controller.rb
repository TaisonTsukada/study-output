class DmnotificationsController < ApplicationController
  after_action :false_to_true
  def index
    @dmnotifications = current_user.passive_dmnotifications
  end

  private

  def false_to_true
    @dmnotifications.where(checked: false).each do |dmnotification|
      dmnotification.update_attributes(checked: true)
    end
  end
end
