class IdeaEditService
  def self.update?(idea, local_params, member_params)
    industry = local_params['local_industries']
    district = local_params['local_districts']
    require_help = local_params['local_require_helps']
    members = member_params['members']
    Idea.transaction do
      byebug
      idea.industries.all.destroy_all
      idea.districts.all.destroy_all
      idea.require_helps.all.destroy_all
      idea.members.all.destroy_all

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
