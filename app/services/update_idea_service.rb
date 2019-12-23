class UpdateIdeaService
  def self.update?(idea, idea_params)
    flag = true

    idea_industries_ids = idea.local_industries.map { |indsutry| indsutry.id}

    idea_districts_ids = idea.local_districts.map { |district| district.id }

    idea_members_ids = idea.local_members.map { |member| member.id }

    idea_require_helps_ids = idea.local_require_helps.map { |help| help.id }

    flag = false unless idea.update(idea_params)

    if flag
      idea_industries_ids.each do |id|
        idea.local_industries.find(id).destroy
      end

      idea_members_ids.each do |id|
        idea.local_members.find(id).destroy
      end

      idea_districts_ids.each do |id|
        idea.local_districts.find(id).destroy
      end

      idea_require_helps_ids.each do |id|
        idea.local_require_helps.find(id).destroy
      end
    end

    flag
  end
end
