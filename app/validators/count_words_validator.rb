class CountWordsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    size = options[:minimum]
    if value.nil? || value.split(/ +/).size < size
      record.errors[attribute] << "#{attribute} need has at least #{size} words"
    end
  end
end
