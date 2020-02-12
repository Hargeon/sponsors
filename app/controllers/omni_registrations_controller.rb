class OmniRegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
    else
      flash[:notice] = 'OOps'
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :phone, :user_type,
                                 :locale, :email, :password,
                                 :provider, :uid)
  end
end
