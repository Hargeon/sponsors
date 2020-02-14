class OmniRegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)
    @auth = session['omni.auth']
    @user.skip_confirmation!
    if @user.save
      sign_in(@user)
      session['omni.auth'] = nil
      redirect_to root_path
    else
      render 'users/omniauth_callbacks/facebook'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :phone, :user_type,
                                 :locale, :email, :password,
                                 :provider, :uid, :avatar)
  end
end
