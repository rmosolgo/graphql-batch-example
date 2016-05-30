require "graphql"
require "graphql/batch"
require_relative "./find_loader"
require_relative "./foreign_key_loader"

ArtistType = GraphQL::ObjectType.define do
  name("Artist")
  field :name, types.String
end

CardType = GraphQL::ObjectType.define do
  name("Card")
  field :name, types.String
  field :expansion, -> { ExpansionType } do
    resolve -> (obj, args, ctx) {
      FindLoader.for(MTG::Expansion).load(obj.expansion_id)
    }
  end
end

ExpansionType = GraphQL::ObjectType.define do
  name("Expansion")
  field :name, types.String
  field :cards, -> { types[CardType] }  do
    resolve -> (obj, args, ctx) {
      ForeignKeyLoader.for(MTG::Card, :expansion_id).load([obj.id])
    }
  end
  field :artists, -> { types[ArtistType] }  do
    resolve -> (obj, args, ctx) {
      ForeignKeyLoader.for(MTG::Card, :expansion_id).load([obj.id]).then do |cards|
        ForeignKeyLoader.for(MTG::Artist, :id).load(cards.map(&:artist_id))
      end
    }
  end
end


QueryType = GraphQL::ObjectType.define do
  field :card, CardType do
    argument :id, !types.Int
    resolve -> (obj, args, ctx) {
      FindLoader.for(MTG::Card).load(args[:id])
    }
  end
end

module MTG
  Schema = GraphQL::Schema.new(query: QueryType)
  Schema.query_execution_strategy = GraphQL::Batch::ExecutionStrategy
end
