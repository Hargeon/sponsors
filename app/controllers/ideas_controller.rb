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

  def create
    @idea = Idea.new(idea_params)
    if IdeaCreateService.create?(@idea, local_information)
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
    params.require(:idea).permit(local_industries: [], local_districts: [],
                                local_members: [], local_require_helps: [])
  end
end
