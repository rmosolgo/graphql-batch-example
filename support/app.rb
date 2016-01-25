require "sequel"
require_relative "./query_logger"
module MTG
  LOGGER = TestLogger.new
  LOGGER.quiet = true
  DB = Sequel.sqlite '', :loggers => [LOGGER]

  DB.create_table(:expansions) do
    primary_key :id
    string :name
    date :released_on
  end

  DB.create_table(:artists) do
    primary_key :id
    string :name
  end

  DB.create_table(:cards) do
    primary_key :id
    string :name
    foreign_key :expansion_id, :expansions
    foreign_key :artist_id, :artists
  end

  class Expansion < Sequel::Model
    one_to_many :cards
    many_to_many :artists, join_table: :cards, uniq: true
  end

  class Artist < Sequel::Model
    one_to_many :cards
    many_to_many :expansions, join_table: :cards, uniq: true
  end

  class Card < Sequel::Model
    many_to_one :artist
    many_to_one :expansion
  end
end
