require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'Should raise constraint error given no name is filled' do
    my_problematic_error = Player.new(name: "Cockatiel")

    expect { my_problematic_error.save }.to(raise_error { |error|
      expect(error).to be_a(ActiveRecord::NotNullViolation)
      expect(error.to_s).to(include("players.email"))
    })
  end
end
