class Stock < ApplicationRecord
  validates_presence_of :company
  validates :name, presence: true, uniqueness: true

  has_one :wallet, as: :owner

  def name=(name)
    super(name.upcase.strip)
  end
end
