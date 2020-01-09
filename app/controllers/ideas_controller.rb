class IdeasController < ApplicationController
  load_and_authorize_resource

  def index
    @ideas = IdeasQueries.new(current_user).find
  end

  def show
    @idea = Idea.find(params[:id])
    @interests = @idea.interests.includes(:user)
    @local_members = @idea.local_members.includes(:member)
  end

  def new
    @idea = current_user.ideas.new
    @local_members = @idea.local_members.includes(:member)
  end

  def edit
    @idea = current_user.ideas.find(params[:id])
    @local_members = @idea.local_members.includes(:member)
  end

  def update
    @idea = current_user.ideas.find(params[:id])
    if UpdateRecordService.new(@idea).update(association_params, idea_params)
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    idea = current_user.ideas.find(params[:id])
    idea.destroy!
    redirect_to ideas_path
  end

  def create
    @idea = current_user.ideas.new(idea_params.merge(association_params))
    if @idea.save
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description, :plan)
  end

  def association_params
    params.require(:idea).permit(local_industries_attributes: [:industry_id],
                                 local_districts_attributes: [:district_id],
                                 local_require_helps_attributes: [:require_help_id],
                                 local_members_attributes: [:amount, :member_id])
  end
end
