class AutofillSerializer
  def initialize(term)
    @term = term
  end

  def as_json(*)
    {
      "suggestions": SearchService.new(@term).union
    }
  end
end
