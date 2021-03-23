module DmnotificationsHelper
  def unchecked_dmnotifications
    @unchecked_dmnotifications = current_user.passive_dmnotifications.where(checked: false)
  end
  #def unchecked_dmnotification(room)
    #dmnotifications = current_user.passive_dmnotifications.where(checked: false)
    #@unchecked_dmnotification = dmnotifications.where(room_id: room.id, checked: false)
  #end
end
