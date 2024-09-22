class Stock < ApplicationRecord
  validates_presence_of :company
  validates :name, presence: true, uniqueness: true

  def name=(name)
    super(name.upcase.strip)
  end
end
