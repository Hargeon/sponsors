class CreateAssociationsService
  def self.create(idea, industries, districts, require_helps, members)
    flag = true
    industries.each { |id| idea.local_industries.create!(industry_id: id) }
    districts.each { |id| idea.local_districts.create!(district_id: id) }
    require_helps.each { |id| idea.local_require_helps.create!(require_help_id: id) }
    members.each do |member|
      new_member = idea.local_members.new(member)
      unless new_member.save
        flag = false
      end
    end
    flag
  end
end
