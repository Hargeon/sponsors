class IdeaLocalTablesService
  def self.create(idea, industry, district, require_help, members)
    industry.each { |index| idea.local_industries.create!(industry_id: index) }
    district.each { |index| idea.local_districts.create!(district_id: index) }
    require_help.each { |index| idea.local_require_helps.create!(require_help_id: index) }
    members.each do |member|
      if member['amount'].scan(/\D/).empty?
        member['amount'] = member['amount'].to_i
        idea.local_members.create!(member) if member['amount'] > 0
      end
    end
  end
end
