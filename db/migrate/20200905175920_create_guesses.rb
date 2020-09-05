class CreateGuesses < ActiveRecord::Migration[6.0]
  def change
    create_table :guesses do |t|
      t.string :chosen_letter, limit: 1, null: false
      t.boolean :winner, null: false
      t.belongs_to :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
