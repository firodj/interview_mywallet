class Transaction < ApplicationRecord
  belongs_to :from_wallet, class_name: Wallet.to_s, optional: true
  belongs_to :to_wallet, class_name: Wallet.to_s, optional: true

  validates_presence_of :from_wallet, :unless => :to_wallet_id?
  validates_presence_of :to_wallet, :unless => :from_wallet_id?
  validates_numericality_of :amount, other_than: 0

  validate :allow_only_status
  validate :moving_amount

  private
    def allow_only_status
      prevent_changed = changed - %w[ status ]
      if self.persisted? && (not prevent_changed.empty?)
        errors.add(:prevent_changed[0], "Change of #{prevent_changed[0]} not allowed!")
      end
    end

    def moving_amount
      if from_wallet == to_wallet
        errors.add(:from_wallet, "Both wallets should be differ!")
      end
    end
end
