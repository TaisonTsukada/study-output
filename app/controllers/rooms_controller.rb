class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms.joins(:messages).includes(:messages).order('messages.created_at DESC')
  end

  def create
    @room = Room.create
    
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @rooms = current_user.rooms.joins(:messages).includes(:messages).order('messages.created_at DESC')
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.page(params[:page]).per(1)
      @message = Message.new
      @entries = @room.entries
      entry = @room.entries.where.not(user_id: current_user)
      @user = entry[0].user
      @dmnotifications = current_user.passive_dmnotifications
      @dmnotifications.where(checked: false).each do |dmnotification|
        dmnotification.update_attributes(checked: true)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
