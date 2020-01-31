class SearchService
  ASSOCIATION_ARRAY = [
    'district_suggestions',
    'help_suggestions',
    'industry_suggestions',
    'member_suggestions'
  ]

  def initialize(term)
    @term = term
  end

  def union
    suggestions = ASSOCIATION_ARRAY.map(&method(:suggestion_for))

    suggestions.flatten.uniq
  end

  private

  def suggestion_for(assciation)
    response_suggestions[assciation].first['options'].map do |item|
      item['text']
    end
  end

  def response_suggestions
    @suggest ||= Idea.suggest(@term).raw_response['suggest']
  end
end
