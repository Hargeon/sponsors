class AutofillSerializer
  def initialize(term)
    @term = term
    @suggest = Idea.suggest(@term).raw_response['suggest']
    init_arrays
  end

  def as_json(*)
    {
      "suggestions": union
    }
  end

  private

  def init_arrays
    @districts = suggestions('district_suggestions')
    @helps = suggestions('help_suggestions')
    @industries = suggestions('industry_suggestions')
    @members = suggestions('member_suggestions')
  end

  def suggestions(assciation)
    @suggest[assciation].first['options'].map do |item|
      item['text']
    end
  end

  def union
    @districts | @helps | @industries | @members
  end
end
