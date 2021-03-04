class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar])

    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :avatar])
  end

  def set_q
    @q = Article.ransack(params[:q])
    @results = @q.result.order(created_at: :desc).page(params[:page]).per(9)
  end
end
