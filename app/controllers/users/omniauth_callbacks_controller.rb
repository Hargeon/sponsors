class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @auth = request.env['omniauth.auth'].to_h
    account = OmniFacebookService.new(@auth)
    if account.registrate?
      sign_in account.user if account.user.present?
      flash[:notice] = account.user.present? ? t('devise.sessions.signed_in') : t(:facebook)
      redirect_to root_path
    else
      @user = User.new
      session['omni.auth'] = @auth
    end
  end
end
