# frozen_string_literal: true

class Player < ApplicationRecord
  has_many :games

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
