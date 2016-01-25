require "graphql"
require "graphql/batch"
require_relative "./find_query"
require_relative "./foreign_key_query"

ArtistType = GraphQL::ObjectType.define do
  name("Artist")
  field :name, types.String
end

CardType = GraphQL::ObjectType.define do
  name("Card")
  field :name, types.String
  field :expansion, -> { ExpansionType } do
    resolve -> (obj, args, ctx) {
      FindQuery.new(MTG::Expansion, obj.expansion_id)
    }
  end
end

ExpansionType = GraphQL::ObjectType.define do
  name("Expansion")
  field :name, types.String
  field :cards, -> { types[CardType] }  do
    resolve -> (obj, args, ctx) {
      ForeignKeyQuery.new(MTG::Card, :expansion_id, obj.id)
    }
  end
  field :artists, -> { types[ArtistType] }  do
    resolve -> (obj, args, ctx) {
      ForeignKeyQuery.new(MTG::Card, :expansion_id, obj.id) do |cards|
        ForeignKeyQuery.new(MTG::Artist, :id, cards.map(&:artist_id))
      end
    }
  end
end


QueryType = GraphQL::ObjectType.define do
  field :card, CardType do
    argument :id, !types.Int
    resolve -> (obj, args, ctx) {
      FindQuery.new(MTG::Card, args[:id])
    }
  end
end

module MTG
  Schema = GraphQL::Schema.new(query: QueryType)
  Schema.query_execution_strategy = GraphQL::Batch::ExecutionStrategy
end
