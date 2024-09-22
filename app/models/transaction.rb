class Transaction < ApplicationRecord
  belongs_to :from_wallet, class_name: Wallet.to_s, optional: true
  belongs_to :to_wallet, class_name: Wallet.to_s, optional: true

  validates_presence_of :from_wallet, :unless => :to_wallet_id?
  validates_presence_of :to_wallet, :unless => :from_wallet_id?
  validates_numericality_of :amount, other_than: 0
end
