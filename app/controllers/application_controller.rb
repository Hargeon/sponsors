class ApplicationController < ActionController::Base
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  private

  def set_locale
    if user_signed_in?
      I18n.locale = current_user.locale
    else
      default_locale
    end
  end

  def default_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
