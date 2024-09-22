class Transaction < ApplicationRecord
  belongs_to :from_wallet
  belongs_to :to_wallet
end
