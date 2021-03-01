class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :image])

    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :image])
  end

  def set_search
    @sarch = Artcile.ransack(params[:q])
    @search_articles = @search.result.page(params[:page])
  end
end
