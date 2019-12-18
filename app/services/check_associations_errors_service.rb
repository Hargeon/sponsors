class CheckAssociationsErrorsService
  def self.find_errors(idea, local_information, members_params)
    @@flag = true
    industries_exist = local_information['local_industries'].nil? ? true : false
    districts_exist = local_information['local_districts'].nil? ? true : false
    require_helps_exist = local_information['local_require_helps'].nil? ? true : false
    members_exist = members_params['members'].nil? ? true : false

    attributes =['Industries', 'Districts', 'Require helps', 'Members']
    params = [industries_exist, districts_exist, require_helps_exist, members_exist]
    params.each_index { |i| add_error(idea, attributes[i]) if(params[i]) }

    @@flag
  end

  private

  def self.add_error(idea, attribute)
    @@flag = false
    idea.errors[:base] << "#{attribute} must exist"
  end
end
