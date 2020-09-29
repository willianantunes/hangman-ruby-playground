# frozen_string_literal: true

class Item < ApplicationRecord
  # model association
  belongs_to :todo

  # validation
  validates :name, presence: true
end
