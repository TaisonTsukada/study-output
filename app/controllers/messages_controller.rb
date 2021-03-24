class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @room = @message.room
      if @message.save
        @roommembernotme = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
        @theid = @roommembernotme.find_by(room_id: @room.id)
        dmnotification = current_user.active_dmnotifications.new(
          room_id: @room.id,
          message_id: @message.id,
          visited_id: @theid.user_id,
          visitor_id: current_user.id,
          action: 'dm'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        dmnotification.checked = true if dmnotification.visitor_id == dmnotification.visited_id
        dmnotification.save if dmnotification.valid?
        if @theid.user.avatar.attached?
          user_image = Rails.application.routes.url_helpers.rails_blob_path(@theid.user.avatar, only_path: true)
        else
          user_image = helpers.asset_url('default_user')
        end
        ActionCable.server.broadcast 'message_channel', content: @message, room_id: @room.id, user_image: user_image
      end
    else
      redirect_to "/rooms/#{@message.room_id}"
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end
