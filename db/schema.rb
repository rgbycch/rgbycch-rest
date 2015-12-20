# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151220205154) do

  create_table "clubs", force: :cascade do |t|
    t.string   "title"
    t.string   "url",        default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "founded"
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "title"
    t.string   "url",        default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "match_day_players", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "player_position_id"
    t.integer  "rating"
    t.integer  "points"
    t.integer  "fouls"
    t.integer  "turnovers_for"
    t.integer  "turnovers_against"
    t.integer  "penalties_won"
    t.integer  "penalties_conceded"
    t.integer  "yellow_cards"
    t.integer  "red_cards"
    t.integer  "carries"
    t.integer  "yards_carried"
    t.integer  "forward_passes"
    t.integer  "successful_lineout_throws"
    t.integer  "unsuccessful_lineout_throws"
    t.integer  "scrums_won"
    t.integer  "scrums_lost"
    t.integer  "successful_garryowens"
    t.integer  "unsuccessful_garryowens"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "match_day_team_id"
  end

  add_index "match_day_players", ["match_day_team_id"], name: "index_match_day_players_on_match_day_team_id"
  add_index "match_day_players", ["player_id"], name: "index_match_day_players_on_player_id"

  create_table "match_day_teams", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_states", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "home_match_day_team_id"
    t.integer  "away_match_day_team_id"
    t.datetime "kick_off_date"
    t.integer  "venue_id"
    t.integer  "referee_id"
    t.integer  "match_state_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "matches", ["venue_id"], name: "index_matches_on_venue_id"

  create_table "officials", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_states", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nick_name"
    t.datetime "dob"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "players_teams", id: false, force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
  end

  add_index "players_teams", ["player_id", "team_id"], name: "index_players_teams_on_player_id_and_team_id"

  create_table "preferred_positions", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "player_position_id"
    t.integer  "preference"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "preferred_positions", ["player_id"], name: "index_preferred_positions_on_player_id"
  add_index "preferred_positions", ["player_position_id"], name: "index_preferred_positions_on_player_position_id"

  create_table "roles", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "position_number"
  end

  create_table "score_types", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "home_score"
    t.integer  "away_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "club_id"
  end

  add_index "teams", ["club_id"], name: "index_teams_on_club_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token",             default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "venues", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
