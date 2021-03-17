module DmnotificationsHelper
  def unchecked_dmnotifications
    @unchecked_dmnotifications = current_user.passive_dmnotifications.where(checked: false)
  end
end
