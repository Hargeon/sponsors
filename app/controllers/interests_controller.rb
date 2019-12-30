class InterestsController < ApplicationController
  load_and_authorize_resource

  def create
    interest = current_user.interests.new(idea_id: params[:idea_id])
    flash[:alert] = 'Something was wrong' unless interest.save
    redirect_to idea_path(Idea.find(params[:idea_id]))
  end
end
