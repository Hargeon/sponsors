class UserEditsController < ApplicationController
  load_and_authorize_resource :user, parent: false

  def update
    I18n.locale = params[:user][:locale]
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to sponsor_path(id: @user.id, locale: @user.locale) if @user.sponsor?

      redirect_to businessman_path(id: @user.id, locale: @user.locale) if @user.businessman?
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :locale, :avatar, :age)
  end
end
