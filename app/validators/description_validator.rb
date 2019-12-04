class DescriptionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.nil? || value.split(/ +/).size < 10
      record.errors[attribute] << 'Description need has at least 10 words'
    end
  end
end
