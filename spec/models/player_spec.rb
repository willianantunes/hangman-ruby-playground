require 'rails_helper'

RSpec.describe Player, type: :model do
  context "Physical database validation" do
    it 'Should raise constraint error given no name is filled' do
      my_problematic_error = Player.new(name: "Cockatiel")

      expect { my_problematic_error.save :validate => false }.to(raise_error { |error|
        expect(error).to be_a(ActiveRecord::NotNullViolation)
        expect(error.to_s).to(include("players.email"))
      })
    end
  end

  context "Model validation" do
    it 'Should raise constraint error given no name is filled' do
      my_problematic_error = Player.new(name: "Cockatiel")

      result = my_problematic_error.save

      expect(result).to be_an_eql(false)
      expect(my_problematic_error.errors.messages[:email][0]).to match("can't be blank")
    end
  end
end
