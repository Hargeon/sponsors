class IdeaSearchService
  def initialize(term)
    @term = term
    @ideas = []
  end

  def find
    find_by_ideas | find_by_industries | find_by_districts | find_by_helps | find_by_members
  end

  def find_by_industries
    Idea.active.joins(:industries).where('LOWER(industries.name) LIKE LOWER(?)', "%#{@term}%")
  end

  def find_by_districts
    Idea.active.joins(:districts).where('LOWER(districts.name) LIKE LOWER(?)', "%#{@term}%")
  end

  def find_by_helps
    Idea.active.joins(:require_helps).where('LOWER(require_helps.name) LIKE LOWER(?)', "%#{@term}%")
  end

  def find_by_members
    Idea.active.joins(:members).where('LOWER(members.name) LIKE LOWER(?)', "%#{@term}%")
  end

  def find_by_ideas
    Idea.active.where('LOWER(name) LIKE LOWER(?)', "%#{@term}%")
        .or(Idea.where('LOWER(description) LIKE LOWER(?)', "%#{@term}%"))
        .or(Idea.where('LOWER(plan) LIKE LOWER(?)', "%#{@term}%"))
  end

  def order_by_created_at
    ideas = find
    ideas.sort { |a, b| b.created_at <=> a.created_at }
  end
end
