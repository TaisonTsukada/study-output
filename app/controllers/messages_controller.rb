class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @room=@message.room
      if @message.save
        @roommembernotme=Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
        @theid=@roommembernotme.find_by(room_id: @room.id)
        dmnotification = current_user.active_dmnotifications.new(
            room_id: @room.id,
            message_id: @message.id,
            visited_id: @theid.user_id,
            visitor_id: current_user.id,
            action: 'dm'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if dmnotification.visitor_id == dmnotification.visited_id
          dmnotification.checked = true
        end
        dmnotification.save if dmnotification.valid?
        ActionCable.server.broadcast 'message_channel', content: @message
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

