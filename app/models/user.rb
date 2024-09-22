class User < ApplicationRecord
  belongs_to :team, optional: true

  validates_presence_of :name, :email
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
