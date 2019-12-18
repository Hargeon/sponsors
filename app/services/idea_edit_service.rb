class IdeaEditService
  def self.update?(idea, local_params, member_params, idea_params)
    industries = local_params['local_industries']
    districts = local_params['local_districts']
    require_helps = local_params['local_require_helps']
    members = member_params['members']

    flag = true
    Idea.transaction do
      idea.update!(idea_params)

      idea.industries.destroy_all
      idea.districts.destroy_all
      idea.require_helps.destroy_all
      idea.members.destroy_all

      flag = CreateAssociationsService.create(idea, industries, districts, require_helps, members)
      unless flag
        raise ActiveRecord::Rollback
      end
    end

    flag
  rescue ActiveRecord::RecordInvalid
    false
  end
end
