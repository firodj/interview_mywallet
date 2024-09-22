class Stock < ApplicationRecord
    validates_presence_of :company
    validates :name, presence: true, uniqueness: true
end
