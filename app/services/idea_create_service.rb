class IdeaCreateService
  def self.create?(idea, local_information)
    Idea.transaction do
      industry = local_information['local_industries']
      district = local_information['local_districts']
      member = local_information['local_members']
      require_help = local_information['local_require_helps']
      idea.save!
      industry.each { |index| idea.local_industries.create!(industry_id: index) }
      district.each { |index| idea.local_districts.create!(district_id: index) }
      member.each { |index| idea.local_members.create!(member_id: index) }
      require_help.each { |index| idea.local_require_helps.create!(require_help_id: index) }
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
