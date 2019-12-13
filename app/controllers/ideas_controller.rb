class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if IdeaEditService.update?(@idea, local_information, member_params, idea_params)
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    idea = Idea.find(params[:id])
    idea.destroy
    redirect_to ideas_path
  end

  def create
    @idea = Idea.new(idea_params)
    if IdeaCreateService.create?(@idea, local_information, member_params)
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description, :plan)
  end

  def local_information
    params.require(:idea).permit(local_industries: [], local_districts: [], local_require_helps: [])
  end

  def member_params
    params.require(:idea).permit(members: [:amount, :member_id])
  end
end
