# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_05_175925) do

  create_table "games", force: :cascade do |t|
    t.boolean "in_progress", default: true, null: false
    t.string "defined_word", limit: 45, null: false
    t.integer "attempts", default: 0, null: false
    t.boolean "perfect_victory"
    t.string "current_situation", null: false
    t.integer "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["defined_word", "player_id"], name: "index_games_on_defined_word_and_player_id", unique: true
    t.index ["player_id"], name: "index_games_on_player_id"
  end

  create_table "guesses", force: :cascade do |t|
    t.string "chosen_letter", limit: 1, null: false
    t.boolean "winner", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_guesses_on_game_id"
  end

  create_table "hits", force: :cascade do |t|
    t.integer "word_position", null: false
    t.integer "guess_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guess_id"], name: "index_hits_on_guess_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.boolean "done"
    t.integer "todo_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["todo_id"], name: "index_items_on_todo_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", limit: 70, null: false
    t.string "email", limit: 320, null: false
    t.date "birthday"
    t.string "gender", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.string "created_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "games", "players"
  add_foreign_key "guesses", "games"
  add_foreign_key "hits", "guesses"
  add_foreign_key "items", "todos"
end
