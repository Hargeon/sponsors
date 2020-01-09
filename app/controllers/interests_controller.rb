class InterestsController < ApplicationController
  load_and_authorize_resource

  def new
    @interest = current_user.interests.new
  end

  def create
    @interest = current_user.interests.new(interest_params)
    @interest.save
    respond_to do |format|
      format.js
    end
  end

  private

  def interest_params
    params.require(:interest).permit(:message, :idea_id)
  end
end
