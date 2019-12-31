class SponsorsController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])
    @interests = @user.interests.includes(:idea)
  end
end
