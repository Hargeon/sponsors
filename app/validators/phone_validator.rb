class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A\+\d+\Z/
      record.errors[attribute] << "#{attribute} has invalid input"
    end
  end
end
