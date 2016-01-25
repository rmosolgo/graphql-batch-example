require_relative "./app"

THOMAS_BAXA = MTG::Artist.create(name: "Thomas Baxa")
ZOLTAN_BOROS = MTG::Artist.create(name: "Zoltan Boros")
WAYNE_REYNOLDS = MTG::Artist.create(name: "Wayne Reynolds")

SHARDS = MTG::Expansion.create(name: "Shards of Alara")
CONFLUX = MTG::Expansion.create(name: "Conflux")
REBORN = MTG::Expansion.create(name: "Alara Reborn")

MTG::Card.create(name: "Volcanic Fallout", artist: ZOLTAN_BOROS, expansion: CONFLUX)
MTG::Card.create(name: "Ignite Disorder", artist: ZOLTAN_BOROS, expansion: CONFLUX)
MTG::Card.create(name: "Wildfield Borderpost", artist: ZOLTAN_BOROS, expansion: REBORN)
MTG::Card.create(name: "Ajani Vengeant", artist: WAYNE_REYNOLDS, expansion: SHARDS)
MTG::Card.create(name: "Madrush Cyclops", artist: WAYNE_REYNOLDS, expansion: CONFLUX)
MTG::Card.create(name: "Wall of Reverence", artist: WAYNE_REYNOLDS, expansion: CONFLUX)
MTG::Card.create(name: "Blightning", artist: THOMAS_BAXA, expansion: SHARDS)
MTG::Card.create(name: "Identity Crisis", artist: THOMAS_BAXA, expansion: REBORN)
MTG::Card.create(name: "Necromancer's Covenant", artist: THOMAS_BAXA, expansion: REBORN)
