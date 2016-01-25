require "graphql"

ArtistType = GraphQL::ObjectType.define do
  name("Artist")
  field :name, types.String
end

CardType = GraphQL::ObjectType.define do
  name("Card")
  field :name, types.String
  field :expansion, -> { ExpansionType }
end

ExpansionType = GraphQL::ObjectType.define do
  name("Expansion")
  field :name, types.String
  field :cards, -> { types[CardType] }
  field :artists, -> { types[ArtistType] }
end

QueryType = GraphQL::ObjectType.define do
  field :card, CardType do
    argument :id, !types.Int
    resolve -> (obj, args, ctx) {
      MTG::Card.find(id: args[:id])
    }
  end
end

module MTG
  Schema = GraphQL::Schema.new(query: QueryType)
end
