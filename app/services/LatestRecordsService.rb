class LatestRecordsService
  def initialize(model, *return_fields, condition: nil)
    @model = model
    @return_fields = return_fields
    @condition = condition
  end

  def call
    process_query
  end

  private

  def process_query
    query = @model.order(created_at: :desc).limit(10)
    query = query.where(@condition) if @condition
    return query.pluck(@return_fields.map(&:to_sym)) if @return_fields.any?

    query
  end
end
