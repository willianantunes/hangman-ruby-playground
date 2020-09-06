require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should belong_to(:player) }
  it { should have_many(:guesses) }
  it { should validate_presence_of(:defined_word) }
  it { should validate_presence_of(:player_id) }
end
