class Player < ApplicationRecord
  validates :name, :email, presence: true
end
