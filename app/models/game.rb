class Game < ApplicationRecord
  belongs_to :player
  has_many :guesses

  validates :defined_word, :player_id, presence: true
end
