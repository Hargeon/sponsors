class UpdateIdeaService
  def self.update?(idea, idea_params)
    flag = true

    idea_industries_ids = idea.local_industries.map(&:id)
    idea_districts_ids = idea.local_districts.map(&:id)
    idea_members_ids = idea.local_members.map(&:id)
    idea_require_helps_ids = idea.local_require_helps.map(&:id)

    Idea.transaction do
      idea.local_industries.where(id: idea_industries_ids).destroy_all
      idea.local_members.where(id: idea_members_ids).destroy_all
      idea.local_districts.where(id: idea_districts_ids).destroy_all
      idea.local_require_helps.where(id: idea_require_helps_ids).destroy_all

      idea.reload

      flag = idea.update(idea_params)

      raise ActiveRecord::Rollback unless flag
    end

    flag
  end
end
