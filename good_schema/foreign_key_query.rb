
class ForeignKeyQuery < GraphQL::Batch::Query
  attr_reader :model, :foreign_key, :foreign_values

  def initialize(model, foreign_key, foreign_values, &block)
    @model = model
    if !foreign_values.is_a?(Array)
      foreign_values = [foreign_values]
    end
    @foreign_key = foreign_key
    @foreign_values = foreign_values
    super(&block)
  end

  # super returns the class name
  def group_key
    "#{super}:#{model.name}:#{foreign_key}"
  end

  def self.execute(queries)
    model = queries.first.model
    foreign_key = queries.first.foreign_key
    foreign_values = queries.map(&:foreign_values).flatten.uniq
    records = model.where(foreign_key => foreign_values).to_a
    queries.each do |query|
      matching_values = query.foreign_values
      matching_records = records.select { |r| matching_values.include?(r.send(foreign_key)) }
      query.complete(matching_records)
    end
  end
end
