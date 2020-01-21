class IdeasQueries
  def initialize(current_user)
    @current_user = current_user
  end

  def sort_by_sponsor_preferences
    ideas = ideas_with_industries | ideas_with_require_helps | ideas_with_districts

    ideas + Idea.active.where.not(id: ideas).order(created_at: :desc)
  end

  def ideas_with_industries
    Idea
      .active
      .joins(:industries)
      .where(
        industries: {
          id: @current_user.industries
        }
      ).order(created_at: :desc)
  end

  def ideas_with_require_helps
    Idea
      .active
      .joins(:require_helps)
      .where(require_helps:
        {
          id: @current_user.require_helps

        }
      ).order(created_at: :desc)
  end

  def ideas_with_districts
    Idea
      .active
      .joins(:districts)
      .where(districts:
        {
          id: @current_user.districts
        }
      ).order(created_at: :desc)
  end

  def find
    return sort_by_sponsor_preferences if @current_user&.sponsor?

    Idea.active.order(created_at: :desc)
  end
end
