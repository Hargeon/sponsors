class IdeaCreateService
  def self.create?(idea, local_information, member_params)
    industry = local_information['local_industries']
    district = local_information['local_districts']
    require_help = local_information['local_require_helps']
    members = member_params['members']

    Idea.transaction do
      idea.save!

      IdeaLocalTablesService.create(idea, industry, district, require_help, members)
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
