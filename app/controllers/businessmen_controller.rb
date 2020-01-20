class BusinessmenController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])
    @ideas = @user.ideas.includes(:interests)
  end
end
