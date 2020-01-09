class IdeasQueries
  def initialize(current_user)
    @current_user = current_user
  end

  def search_by_criteria
    ideas = ideas_with_industries | ideas_with_require_helps | ideas_with_districts

    ideas + Idea.where.not(id: ideas).order(created_at: :desc)
  end

  def ideas_with_industries
    Idea
      .joins(:industries)
      .where(
        industries: {
          id: Industry
                .from(@current_user.industries
                        .distinct, :industries)
                .order(created_at: :desc)
        })
  end

  def ideas_with_require_helps
    Idea
      .joins(:require_helps)
      .where(require_helps:
        {
          id: RequireHelp
                .from(@current_user.require_helps
                        .distinct, :require_helps)
                .order(created_at: :desc)
        })
  end

  def ideas_with_districts
    Idea
      .joins(:districts)
      .where(districts:
        {
          id: District
              .from(@current_user.districts
                      .distinct, :districts)
              .order(created_at: :desc)
        })
  end

  def find
    if @current_user&.sponsor?
      search_by_criteria
    else
      @ideas = Idea.order(created_at: :desc)
    end
  end
end
