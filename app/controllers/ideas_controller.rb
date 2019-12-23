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
    temp_idea = Idea.new(idea_params)
    if temp_idea.valid?
      if UpdateIdeaService.update?(@idea, idea_params)
        redirect_to idea_path(@idea)
      else
        flash[:alert] = @idea.errors.full_messages
        redirect_to edit_idea_path(@idea)
      end
    else
      flash[:alert] = temp_idea.errors.full_messages
      redirect_to edit_idea_path(@idea)
    end
  end

  def destroy
    idea = Idea.find(params[:id])
    idea.destroy
    redirect_to ideas_path
  end

  def create
    @idea = Idea.new(idea_params)
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
