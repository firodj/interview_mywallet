class Wallet < ApplicationRecord
  validate :owner_not_changed

  belongs_to :owner, polymorphic: true

  private
    def owner_not_changed
      if self.persisted? && (owner_id_changed? || owner_type_changed?)
        errors.add(:owner, "Change of owner not allowed!")
      end
    end
end
