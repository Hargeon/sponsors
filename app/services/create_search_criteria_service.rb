class CreateSearchCriteriaService
  def self.create?(user, sponsor_params)
    flag = true

    sponsor_industries_ids = user.sponsor_industries.map(&:id)
    sponsor_districts_ids = user.sponsor_districts.map(&:id)
    sponsor_helps_ids = user.sponsor_helps.map(&:id)

    User.transaction do
      user.sponsor_industries.where(id: sponsor_industries_ids).destroy_all
      user.sponsor_districts.where(id: sponsor_districts_ids).destroy_all
      user.sponsor_helps.where(id: sponsor_helps_ids).destroy_all

      user.reload

      flag = user.update(sponsor_params)

      raise ActiveRecord::Rollback unless flag
    end

    flag
  end
end
