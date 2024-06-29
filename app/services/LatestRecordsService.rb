class LatestRecordsService
  def initialize(model, *return_fields, condition: nil, cache_name: nil)
    @model = model
    @return_fields = return_fields
    @condition = condition
    @cache_name = cache_name
  end

  def call
    get_lastest_records
  end

  private

  def get_lastest_records
    Rails.cache.fetch(@cache_name, expires_in: 10.minutes) do
      process_query
    end
  end

  def process_query
    query = @model.order(created_at: :desc).limit(10)
    query = query.where(@condition) if @condition
    return query.pluck(@return_fields.map(&:to_sym)) if @return_fields.any?

    query
  end
end
