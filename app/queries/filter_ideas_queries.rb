class FilterIdeasQueries
  def initialize(criteria_hash)
    @matching = [
      {
        match: {
          active: true
        }
      }
    ]

    @query = {
      query: {
        bool: {
          must: []
        }
      },
      sort: [
        { created_at: :desc }
      ]
    }

    @criteria_hash = criteria_hash
  end

  def elastic_query
    @criteria_hash.each do |key, value|
      add_to_query_array(value, key + '.name')
    end

    @query[:query][:bool][:must] = @matching

    @query
  end

  private

  def add_to_query_array(term, name)
    return if term.blank?

    @matching << {
      match: {
        name => term
      }
    }
  end
end
