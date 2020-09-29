# frozen_string_literal: true

class Hit < ApplicationRecord
  belongs_to :guess

  validates :word_position, presence: true
end
