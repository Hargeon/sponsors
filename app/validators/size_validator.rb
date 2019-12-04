class SizeValidator < ActiveModel::EachValidator
  DEFAULT = 10
  def validate_each(record, attribute, value)
    size = DEFAULT
    size = options[:minimum] if options.key?(:minimum)
    if value.nil? || value.split(/ +/).size < size
      record.errors[attribute] << "#{attribute} need has at least 10 words"
    end
  end
end
