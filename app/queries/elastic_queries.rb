module ElasticQueries
  def full_text_search(term)
    {
      query: {
        bool: {
          must: [
            {
              multi_match: {
                query: term,
                fields: [
                  :name, :description, :plan,
                  'industries.name', 'districts.name', 'require_helps.name',
                  'members.name'
                ]
              }
            },
            {
              match: {
                active: true
              }
            }
          ]
        }
      },
      sort: [
        { created_at: :desc }
      ]
    }
  end

  def suggest_tags(term)
    {
      suggest: {
        text: term,
        industry_suggestions: {
          completion: {
            field: 'industries.name',
            skip_duplicates: true,
            size: 3
          }
        },
        district_suggestions: {
          completion: {
            field: 'districts.name',
            skip_duplicates: true,
            size: 3
          }
        },
        help_suggestions: {
          completion: {
            field: 'require_helps.name',
            skip_duplicates: true,
            size: 3
          }
        },
        member_suggestions: {
          completion: {
            field: 'members.name',
            skip_duplicates: true,
            size: 3
          }
        }
      }
    }
  end
end
