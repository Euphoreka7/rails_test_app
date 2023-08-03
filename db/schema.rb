# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_03_045307) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_settings", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "experiment_id", null: false
    t.bigint "experiment_option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "experiment_id"], name: "index_client_settings_on_client_id_and_experiment_id", unique: true
    t.index ["client_id"], name: "index_client_settings_on_client_id"
    t.index ["experiment_id"], name: "index_client_settings_on_experiment_id"
    t.index ["experiment_option_id"], name: "index_client_settings_on_experiment_option_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "device_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "experiment_options", force: :cascade do |t|
    t.string "value", null: false
    t.float "percentage", null: false
    t.bigint "experiment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experiment_id", "value"], name: "index_experiment_options_on_experiment_id_and_value", unique: true
    t.index ["experiment_id"], name: "index_experiment_options_on_experiment_id"
  end

  create_table "experiments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_experiments_on_name", unique: true
  end

  add_foreign_key "client_settings", "clients"
  add_foreign_key "client_settings", "experiment_options"
  add_foreign_key "client_settings", "experiments"
  add_foreign_key "experiment_options", "experiments"
end
