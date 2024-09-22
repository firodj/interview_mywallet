class Transaction < ApplicationRecord
  belongs_to :from_wallet, class_name: Wallet.to_s
  belongs_to :to_wallet, class_name: Wallet.to_s
end
