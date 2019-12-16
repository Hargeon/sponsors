class CreateAssociationsService
  def self.create(idea, industries, districts, require_helps, members)
    industries.each { |id| idea.local_industries.create!(industry_id: id) } unless industries.nil?
    districts.each { |id| idea.local_districts.create!(district_id: id) } unless districts.nil?
    require_helps.each { |id| idea.local_require_helps.create!(require_help_id: id) } unless require_helps.nil?
    members.each { |member| idea.local_members.create!(member) } unless members.nil?
  end
end
