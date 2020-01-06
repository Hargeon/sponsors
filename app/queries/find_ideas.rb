class FindIdeas
  def initialize(current_user)
    @current_user = current_user
  end

  def find
    ideas = Idea.joins(:industries).merge(Industry.from(Industry
                .where(id: @current_user.industries)
                .distinct, :industries).order(created_at: :desc))

    ideas |= Idea.joins(:require_helps).merge(RequireHelp
                 .from(RequireHelp.where(id: @current_user.require_helps)
                 .distinct, :require_helps).order(created_at: :desc))

    ideas |= Idea.joins(:districts).merge(District.from(District
                 .where(id: @current_user.districts)
                 .distinct, :districts).order(created_at: :desc))

    ideas + Idea.where.not(id: ideas)
  end
end
