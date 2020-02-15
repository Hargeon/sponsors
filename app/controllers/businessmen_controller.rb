class BusinessmenController < ApplicationController
  load_and_authorize_resource :user, parent: false

  def show
    @pagy, @ideas = pagy(@user.ideas.includes(:interests), items: 5)
  end
end
