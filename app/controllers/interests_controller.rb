class InterestsController < ApplicationController
  load_and_authorize_resource

  def new
    @interests = current_user.interests.new
    @idea_id = params[:idea_id]
  end

  def create
    @interest = current_user.interests.new(interest_params)
    respond_to do |format|
      @interest.save
      format.js
    end
  end

  private

  def interest_params
    params.require(:interest).permit(:message, :idea_id)
  end
end
