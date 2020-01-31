class AutofillSerializer
  def initialize(union)
    @union = union
  end

  def as_json(*)
    {
      "suggestions": @union
    }
  end
end
