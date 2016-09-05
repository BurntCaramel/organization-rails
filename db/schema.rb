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

ActiveRecord::Schema.define(version: 20160905021643) do

  create_table "item_tag_relationships", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "tag_id"
    t.string   "item_sha_256",    null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id", "item_sha_256"], name: "by_organization_item"
    t.index ["organization_id", "tag_id", "item_sha_256"], name: "by_organization_tag_item", unique: true
    t.index ["organization_id"], name: "index_item_tag_relationships_on_organization_id"
    t.index ["tag_id"], name: "index_item_tag_relationships_on_tag_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "owner_identifier"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id", "name"], name: "index_tags_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_tags_on_organization_id"
  end

  create_table "user_organization_capabilities", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "user_identifier"
    t.string   "capabilities"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_user_organization_capabilities_on_organization_id"
  end

end
