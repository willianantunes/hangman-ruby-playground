class CreateHits < ActiveRecord::Migration[6.0]
  def change
    create_table :hits do |t|
      t.integer :word_position, null: false
      t.belongs_to :guess, null: false, foreign_key: true

      t.timestamps
    end
  end
end
