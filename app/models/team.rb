class Team < ApplicationRecord
    validates_presence_of :name

    has_many :users
    has_one :wallet, as: :owner
end
