class IdeasController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user&.sponsor?
      @ideas = Idea.joins(:industries).merge(Industry.where(id: current_user.industries).distinct)
      @ideas |= Idea.joins(:require_helps).merge(RequireHelp.where(id: current_user.require_helps).distinct)
      @ideas |= Idea.joins(:districts).merge(District.where(id: current_user.districts).distinct)
      @ideas += Idea.where.not(id: @ideas)
    else
      @ideas = Idea.all
    end
  end

  def show
    @idea = Idea.find(params[:id])
    @interests = @idea.interests.includes(:user)
  end

  def new
    @idea = current_user.ideas.new
  end

  def edit
    @idea = current_user.ideas.find(params[:id])
  end

  def update
    @idea = current_user.ideas.find(params[:id])
    if UpdateIdeaService.update?(@idea, idea_params)
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
    @idea = current_user.ideas.new(idea_params)
    if @idea.save
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description, :plan,
                                 local_industries_attributes: [:industry_id],
                                 local_districts_attributes: [:district_id],
                                 local_require_helps_attributes: [:require_help_id],
                                 local_members_attributes: [:amount, :member_id])
  end
end
