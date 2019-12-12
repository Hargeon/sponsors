class IdeaCreateService
  def self.create?(idea, local_information, member_params)
    industry = local_information['local_industries']
    district = local_information['local_districts']
    require_help = local_information['local_require_helps']
    members = member_params['members']

    Idea.transaction do
      idea.save!
      industry.each { |index| idea.local_industries.create!(industry_id: index) }
      district.each { |index| idea.local_districts.create!(district_id: index) }
      members.each do |member|
        if member['amount'].scan(/\D/).empty?
          member['amount'] = member['amount'].to_i
          idea.local_members.create!(member) if member['amount'] > 0
        end
      end
      require_help.each { |index| idea.local_require_helps.create!(require_help_id: index) }
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
