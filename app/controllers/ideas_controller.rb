class IdeasController < ApplicationController
  load_and_authorize_resource

  ELASTICSEARCH_MIN_SIZE = 5

  def index
    @pagy, @ideas = pagy_array(IdeasQueries.new(current_user).find, items: 10)
  end

  def show
    @interests = @idea.interests.includes(:user)
    @local_members = @idea.local_members.includes(:member)
    ViewService.new(current_user, @idea).find_or_create
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
    @local_members = @idea.local_members.includes(:member)
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
    @local_members = @idea.local_members.includes(:member)
    if @idea.save
      SendMailsToSponsorsWorker.perform_async(@idea.id)
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def update_active_time
    idea = Idea.find(params[:id])
    idea.update!(active_time: Time.zone.now, active: true)
    redirect_to idea_path(idea)
  end

  def search
    @ideas = Idea.search(params[:term]).page(2).results
#    count_pages = @ideas.raw_response['hits']['total']['value']
#    count_pages = (count_pages.to_f / 10).ceil
    #.page(count_pages)
    @pagy = Pagy.new_from_elasticsearch_rails(@ideas)

    if @ideas.size < ELASTICSEARCH_MIN_SIZE
      @pagy, @ideas = pagy_array(IdeaSearchService.new(params[:term]).order_by_created_at, items: 10)
    end

    render 'index'
  end

  def filter
    criteria_hash = params['category']

    query = FilterIdeasQueries.new(criteria_hash).elastic_query

    @ideas = Idea.filter(query)
    byebug
    @pagy = Pagy.new_from_elasticsearch_rails(@ideas)

    render 'index'
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
