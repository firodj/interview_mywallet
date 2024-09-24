# MyWallet

This is a rails application or intnernal wallet.

## Question

Goal: Internal wallet transactional system (API)

Requirements:

* Based on relationships every entity e.g. User, Team, Stock or any other should
have their own defined "wallet" to which we could transfer money or withdraw.
* Every request for credit/debit (deposit or withdraw) should be based on records in
database for given model,
* Every instance of a single transaction should have proper validations against
required fields and their source and targetwallet, e.g. from who we are taking money
and transferring to whom? (`Credits == source wallet == nil`,
`Debits == targetwallet == nil`).
* Each record should be created in database transactions to comply with ACID
standards.
* Balance for given entity (User, Team, Stock) should be calculated by summing
records.

Tasks:

1. Architect generic wallet solution (money manipulation) between entities (User,
Stock, Team or any other).
2. Create model relationships and validations for achieving proper calculations of every
wallet, transactions.
3. Use STI (or any other design pattern) for proper money manipulation.
4. Apply your own sign in (new session solution, no sign up is needed) without any external
gem.
5. Create a `LatestStockPrice` library (in lib folder in **gem style**) for **price**, **prices** and
**price_all** endpoints - https://rapidapi.com/suneetk92/api/latest-stock-price

## Design

For transactional service we need Wallet model and Transaction model. The Wallet holds balance from owner account,
and Transaction holds transactional activity for deposit, withdraw and transfer. Sice

Wallet:
+ id
+ owner (owner_id, owner_type)
+ balance
+ timestamp

Transaction:
+ id
+ from_wallet_id (belongs to Wallet)
+ to_wallet_id (belongs to Wallet)
+ amount
+ timestamp

For owner we have User, Team and Stock.

Team:
+ id
+ name

User:
+ id
+ name
+ email
+ team_id (nullable)

Stock:
+ id
+ name
+ company

The API using simple authenticated mechanism.
To access resources related to system, pass header `Authorization: Plain system`.

```
/api/v1/teams
/api/v1/stocks
/api/v1/users
/api/v1/wallets
/api/v1/transactions
```

and to access transactional related API, pass header `Authorization: Plain <email>`

```
/api/v1/user/wallet
/api/v1/user/deposit
/api/v1/user/withdraw
/api/v1/user/transfer
/api/v1/user/transactions
```

## Running Test

bundle exec rails db:test:prepare
bundle exec rails test

## Running Server

bundle exec rails db:migrate
bundle exec rails server
