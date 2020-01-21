class BusinessmenController < ApplicationController
  load_and_authorize_resource :user, parent: false

  def show
    @ideas = @user.ideas.includes(:interests)
  end
end
