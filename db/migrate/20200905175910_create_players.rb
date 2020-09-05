class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, limit: 70, null: false
      t.string :email, limit: 320, null: false
      t.date :birthday
      t.string :gender, limit: 1

      t.timestamps
    end
  end
end
