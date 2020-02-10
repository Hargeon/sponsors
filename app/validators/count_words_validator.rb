class CountWordsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    size = options[:minimum]
    if value.nil? || value.split(/ +/).size < size
      record.errors.add(attribute, :count_words, size: size)
    end
  end
end
