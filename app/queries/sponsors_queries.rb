class SponsorsQueries
  def initialize(idea)
    @idea = idea
  end

  def idea_will_like_sponsors
    sponsors_with_industries | sponsor_with_districts | sponsor_with_require_helps
  end

  def sponsors_with_industries
    User.sponsors.joins(:industries).where(industries: { id: @idea.industries })
  end

  def sponsor_with_districts
    User.sponsors.joins(:districts).where(districts: { id: @idea.districts })
  end

  def sponsor_with_require_helps
    User.sponsors.joins(:require_helps).where(require_helps: { id: @idea.require_helps })
  end
end
