require 'rails_helper'

RSpec.describe Guess, type: :model do
  it { should belong_to(:game) }
  it { should have_many(:hits) }
end
