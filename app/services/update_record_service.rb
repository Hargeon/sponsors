class UpdateRecordService
  def initialize(record)
    @record = record
  end

  def update(associations_params, record_params = {})
    flag = true

    Idea.transaction do
      associations_params.each do |key, _|
        association = key.sub('_attributes', '')
        ids = @record.send(association).map(&:id)
        @record.send(association).where(id: ids).destroy_all
      end

      @record.reload
      associations_params = clear_params(associations_params)
      flag = @record.update(record_params.merge(associations_params))

      raise ActiveRecord::Rollback unless flag
    end

    @record.reload

    flag
  end

  private

  def clear_params(associations_params)
    associations_params.select { |_, value| value[0].present? }
  end
end
