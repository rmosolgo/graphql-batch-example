# Load instances of the same class by ID.
#
# Instead of:
#   - SELECT * FROM cards WHERE id=1;
#   - SELECT * FROM cards WHERE id=2;
#   - SELECT * FROM cards WHERE id=3;
#
# Execute:
#   - SELECT * FROM cards WHERE id IN(1,2,3);
class FindLoader < GraphQL::Batch::Loader
  def initialize(model)
    @model = model
  end

  def perform(ids)
    records = @model.where(id: ids.uniq)
    records.each { |record| fulfill(record.id, record) }
    # If a record wasnt found, fulfill with nil:
    ids.each { |id| fulfill(id, nil) unless fulfilled?(id) }
  end
end
