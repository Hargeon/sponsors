class IdeaEditService
  def self.update?(idea, local_params, member_params, idea_params)
    industry = local_params['local_industries']
    district = local_params['local_districts']
    require_help = local_params['local_require_helps']
    members = member_params['members']

    Idea.transaction do
      idea.update!(idea_params)

      idea.industries.destroy_all
      idea.districts.destroy_all
      idea.require_helps.destroy_all
      idea.members.destroy_all

      IdeaLocalTablesService.create(idea, industry, district, require_help, members)
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
