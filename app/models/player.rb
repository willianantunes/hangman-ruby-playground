class Player < ApplicationRecord
  has_many :games

  validates :name, :email, presence: true
end
