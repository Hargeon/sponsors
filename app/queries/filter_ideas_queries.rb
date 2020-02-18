class FilterIdeasQueries
  QUERY = {
    query: {
      bool: {
        must: []
      }
    },
    sort: [
      { created_at: { order: :desc, unmapped_type: 'date' } }
    ]
  }.freeze

  def initialize(criteria_hash)
    @criteria_hash = criteria_hash
  end

  def elastic_query
    query = QUERY
    query[:query][:bool][:must] = setup_matching
    query
  end

  private

  def setup_matching
    matching = [
      {
        match: {
          active: true
        }
      }
    ]

    criteria_array = @criteria_hash.to_unsafe_h.map do |key, value|
      next if value.blank?

      {
        match: {
          "#{key}.name" => value
        }
      }
    end

    matching + criteria_array.compact
  end
end
