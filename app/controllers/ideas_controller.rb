class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
    @idea.local_industries.build
    @idea.local_districts.build
    @idea.local_members.build
    @idea.local_require_helps.build
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
    params.require(:idea).permit(:name, :description, :plan, local_industries_attributes: [industry_id: []],
                                local_districts_attributes: [district_id: []], local_members_attributes: [member_id: []],
                                local_require_helps_attributes: [require_help_id: []])
  end
end
