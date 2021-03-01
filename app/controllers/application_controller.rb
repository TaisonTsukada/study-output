class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :image])

    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :image])
  end

  def set_q
    @q = Article.ransack(params[:q])
    @results = @q.result.page(params[:page]).per(9)
  end
end
