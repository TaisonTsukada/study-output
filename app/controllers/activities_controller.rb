class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @activities = current_user.active_notifications.page(params[:page]).per(20)
    respond_to do |format|
      format.js
    end
  end
end
