class Guess < ApplicationRecord
  belongs_to :game
  has_many :hits
end
