class PlanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.nil? || value.split(/ +/).size < 10
      record.errors[attribute] << 'Plan need has at least 10 words'
    end
  end
end
