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

ActiveRecord::Schema.define(version: 20161119054749) do

  create_table "channels", force: :cascade do |t|
    t.integer  "organization_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name",            null: false
    t.index ["organization_id", "name"], name: "index_channels_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_channels_on_organization_id"
  end

  create_table "item_tag_relationships", force: :cascade do |t|
    t.integer  "tag_id",       null: false
    t.string   "item_sha_256", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["item_sha_256"], name: "by_item"
    t.index ["tag_id", "item_sha_256"], name: "by_tag_item", unique: true
    t.index ["tag_id"], name: "index_item_tag_relationships_on_tag_id"
  end

  create_table "organization_invitations", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "email"
    t.string   "capabilities"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_organization_invitations_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "owner_identifier", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["owner_identifier"], name: "index_organizations_on_owner_identifier"
  end

  create_table "ripples", force: :cascade do |t|
    t.integer  "channel_id",            null: false
    t.binary   "key_id",     limit: 16, null: false
    t.binary   "info",                  null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["channel_id", "created_at"], name: "index_ripples_on_channel_id_and_created_at"
    t.index ["channel_id", "key_id", "created_at"], name: "index_ripples_on_channel_id_and_key_id_and_created_at", unique: true
    t.index ["channel_id"], name: "index_ripples_on_channel_id"
  end

  create_table "service_credentials", force: :cascade do |t|
    t.integer  "organization_id",   null: false
    t.binary   "encrypted_info",    null: false
    t.binary   "encrypted_info_iv", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "kind",              null: false
    t.index ["organization_id", "kind"], name: "index_service_credentials_on_organization_id_and_kind", unique: true
    t.index ["organization_id"], name: "index_service_credentials_on_organization_id"
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
    t.index [nil, "user_identifier"], name: "index_organization_user_identifier"
  end

end
