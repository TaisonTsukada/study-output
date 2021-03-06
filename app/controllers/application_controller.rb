class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q_for_article

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar])

    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :avatar])
  end

  def set_q_for_article
    @q_header = Article.ransack(params[:q])
  end
end
