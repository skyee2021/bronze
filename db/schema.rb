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

ActiveRecord::Schema.define(version: 2021_07_20_091228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "missions", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.index ["description"], name: "index_missions_on_description"
    t.index ["status"], name: "index_missions_on_status"
    t.index ["title"], name: "index_missions_on_title"
  end

end
