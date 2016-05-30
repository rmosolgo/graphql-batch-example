require_relative "./support/seeds"
require 'pp'

if ARGV[0] == "bad"
  require_relative "./bad_schema/schema"
elsif ARGV[0] == "good"
  require_relative "./good_schema/schema"
else
  raise("Pass `good` or `bad` to demonstrate a schema")
end

MTG::LOGGER.quiet = false

query_string = %|
  query getCard {
    card_1: card(id: 1) { ... cardFields }
    card_2: card(id: 2) { ... cardFields }
    card_3: card(id: 3) { ... cardFields }
    card_4: card(id: 4) { ... cardFields }
    card_5: card(id: 5) { ... cardFields }
    card_6: card(id: 6) { ... cardFields }
  }
  fragment cardFields on Card {
    expansion {
      name
      cards {
        name
      }
      artists {
        name
      }
    }
  }
|

result = MTG::Schema.execute(query_string)
# If you want to see the result:
pp result
