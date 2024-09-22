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
+ ~~currency~~
+ timestamp

bundle exec rails g scaffold Wallet owner:references{polymorphic} 'balance:decimal{8,2}'

Transaction:
+ id
+ from_wallet_id (belongs to Wallet)
+ to_wallet_id (belongs to Wallet)
+ amount
+ ~~from_currency~~
+ ~~converted_amount~~
+ ~~to_currency~~
+ status
+ timestamp

bundle exec rails g scaffold Transaction from_wallet:references to_wallet:references 'amount:decimal{8,2}'

For owner we have User, Team and Stock.

Team:
+ id
+ name

bundle exec rails g scaffold team name:string

User:
+ id
+ name
+ email
+ team_id

bundle exec rails g scaffold user name:string email:string:uniq team:references

Stock:
+ id
+ name
+ company

bundle exec rails g scaffold stock name:string:uniq company:string

## RoR

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
