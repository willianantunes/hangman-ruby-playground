class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.boolean :in_progress, default: true, null: false
      t.string :defined_word, limit: 45, null: false
      t.integer :attempts, null: false, default: 0
      t.boolean :perfect_victory
      t.string :current_situation, null: false
      t.belongs_to :player, null: false, foreign_key: true

      t.timestamps
    end

    add_index(:games, [:defined_word, :player_id], unique: true)
  end
end
