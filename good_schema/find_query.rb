# Find objects by ID, from the Shopify example
class FindQuery < GraphQL::Batch::Query
  attr_reader :model, :id

  def initialize(model, id, &block)
    @model = model
    @id = id
    super(&block)
  end

  # super returns the class name
  def group_key
    "#{super}:#{model.name}"
  end

  def self.execute(queries)
    model = queries.first.model
    ids = queries.map(&:id)
    records = model.where(id: ids.uniq).each_with_object({}) do |record, acc|
      acc[record.id] = record
    end

    queries.each do |query|
      record = records[query.id]
      query.complete(record)
    end
  end
end
