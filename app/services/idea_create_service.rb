class IdeaCreateService
  def self.create?(idea, local_information, member_params)
    industries = local_information['local_industries']
    districts = local_information['local_districts']
    require_helps = local_information['local_require_helps']
    members = member_params['members']

    Idea.transaction do
      idea.save!

      CreateAssociationsService.create(idea, industries, districts, require_helps, members)
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
