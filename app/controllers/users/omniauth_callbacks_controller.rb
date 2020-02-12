class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @auth = request.env['omniauth.auth']
    @account = User.where(provider: @auth.provider, uid: @auth.uid)
    if @account.present?
      sign_in @account
      redirect_to root_path
    end
  end
end
