# GraphQL::Batch Example

This is a "before & after" example of [https://github.com/shopify/graphql-batch].

It logs SQL queries during query execution.

## Before

```
~/projects/graphql-batch-example $ bundle exec ruby run_query.rb bad
I, [2016-01-24T22:49:25.537066 #92405]  INFO -- : (0.000120s) SELECT * FROM `cards` WHERE (`id` = 1) LIMIT 1
I, [2016-01-24T22:49:25.537388 #92405]  INFO -- : (0.000093s) SELECT * FROM `expansions` WHERE `id` = 2
I, [2016-01-24T22:49:25.537915 #92405]  INFO -- : (0.000122s) SELECT * FROM `cards` WHERE (`cards`.`expansion_id` = 2)
I, [2016-01-24T22:49:25.538630 #92405]  INFO -- : (0.000107s) SELECT `artists`.* FROM `artists` INNER JOIN `cards` ON (`cards`.`artist_id` = `artists`.`id`) WHERE (`cards`.`expansion_id` = 2)
I, [2016-01-24T22:49:25.538997 #92405]  INFO -- : (0.000076s) SELECT * FROM `cards` WHERE (`id` = 2) LIMIT 1
I, [2016-01-24T22:49:25.539237 #92405]  INFO -- : (0.000085s) SELECT * FROM `expansions` WHERE `id` = 2
I, [2016-01-24T22:49:25.539504 #92405]  INFO -- : (0.000094s) SELECT * FROM `cards` WHERE (`cards`.`expansion_id` = 2)
I, [2016-01-24T22:49:25.539871 #92405]  INFO -- : (0.000099s) SELECT `artists`.* FROM `artists` INNER JOIN `cards` ON (`cards`.`artist_id` = `artists`.`id`) WHERE (`cards`.`expansion_id` = 2)
I, [2016-01-24T22:49:25.540216 #92405]  INFO -- : (0.000078s) SELECT * FROM `cards` WHERE (`id` = 3) LIMIT 1
I, [2016-01-24T22:49:25.540445 #92405]  INFO -- : (0.000072s) SELECT * FROM `expansions` WHERE `id` = 3
I, [2016-01-24T22:49:25.540727 #92405]  INFO -- : (0.000094s) SELECT * FROM `cards` WHERE (`cards`.`expansion_id` = 3)
I, [2016-01-24T22:49:25.541057 #92405]  INFO -- : (0.000089s) SELECT `artists`.* FROM `artists` INNER JOIN `cards` ON (`cards`.`artist_id` = `artists`.`id`) WHERE (`cards`.`expansion_id` = 3)
I, [2016-01-24T22:49:25.541388 #92405]  INFO -- : (0.000074s) SELECT * FROM `cards` WHERE (`id` = 4) LIMIT 1
I, [2016-01-24T22:49:25.541578 #92405]  INFO -- : (0.000068s) SELECT * FROM `expansions` WHERE `id` = 1
I, [2016-01-24T22:49:25.541839 #92405]  INFO -- : (0.000083s) SELECT * FROM `cards` WHERE (`cards`.`expansion_id` = 1)
I, [2016-01-24T22:49:25.542128 #92405]  INFO -- : (0.000083s) SELECT `artists`.* FROM `artists` INNER JOIN `cards` ON (`cards`.`artist_id` = `artists`.`id`) WHERE (`cards`.`expansion_id` = 1)
I, [2016-01-24T22:49:25.542448 #92405]  INFO -- : (0.000077s) SELECT * FROM `cards` WHERE (`id` = 5) LIMIT 1
I, [2016-01-24T22:49:25.542667 #92405]  INFO -- : (0.000070s) SELECT * FROM `expansions` WHERE `id` = 2
I, [2016-01-24T22:49:25.542940 #92405]  INFO -- : (0.000097s) SELECT * FROM `cards` WHERE (`cards`.`expansion_id` = 2)
I, [2016-01-24T22:49:25.543285 #92405]  INFO -- : (0.000092s) SELECT `artists`.* FROM `artists` INNER JOIN `cards` ON (`cards`.`artist_id` = `artists`.`id`) WHERE (`cards`.`expansion_id` = 2)
I, [2016-01-24T22:49:25.543568 #92405]  INFO -- : (0.000067s) SELECT * FROM `cards` WHERE (`id` = 6) LIMIT 1
I, [2016-01-24T22:49:25.543750 #92405]  INFO -- : (0.000064s) SELECT * FROM `expansions` WHERE `id` = 2
I, [2016-01-24T22:49:25.544019 #92405]  INFO -- : (0.000095s) SELECT * FROM `cards` WHERE (`cards`.`expansion_id` = 2)
I, [2016-01-24T22:49:25.544357 #92405]  INFO -- : (0.000091s) SELECT `artists`.* FROM `artists` INNER JOIN `cards` ON (`cards`.`artist_id` = `artists`.`id`) WHERE (`cards`.`expansion_id` = 2)
```

## After

```
~/projects/graphql-batch-example $ bundle exec ruby run_query.rb good
I, [2016-01-24T22:49:55.412548 #92430]  INFO -- : (0.000234s) SELECT * FROM `cards` WHERE (`id` IN (1, 2, 3, 4, 5, 6))
I, [2016-01-24T22:49:55.413479 #92430]  INFO -- : (0.000172s) SELECT * FROM `expansions` WHERE (`id` IN (2, 3, 1))
I, [2016-01-24T22:49:55.414457 #92430]  INFO -- : (0.000190s) SELECT * FROM `cards` WHERE (`expansion_id` IN (2, 3, 1))
I, [2016-01-24T22:49:55.415565 #92430]  INFO -- : (0.000178s) SELECT * FROM `artists` WHERE (`id` IN (2, 3, 1))
```

## 💰
