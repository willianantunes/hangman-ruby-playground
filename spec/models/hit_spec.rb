require 'rails_helper'

RSpec.describe Hit, type: :model do
  it { should belong_to(:guess) }
  it { should validate_presence_of(:word_position) }
end
