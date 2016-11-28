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

ActiveRecord::Schema.define(version: 20161124154414) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "advertisements", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "image",      limit: 65535
    t.string   "url",        limit: 255
    t.integer  "position",   limit: 4
    t.integer  "order_no",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "idols", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "idols_videos", force: :cascade do |t|
    t.integer  "idol_id",    limit: 4
    t.integer  "video_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "idols_videos", ["idol_id"], name: "index_idols_videos_on_idol_id", using: :btree
  add_index "idols_videos", ["video_id"], name: "index_idols_videos_on_video_id", using: :btree

  create_table "relevance_scores", force: :cascade do |t|
    t.integer  "referer_idol_id",  limit: 4,             null: false
    t.integer  "request_idol_id",  limit: 4,             null: false
    t.integer  "appearance_count", limit: 4, default: 0
    t.integer  "click_count",      limit: 4, default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "relevance_scores", ["referer_idol_id", "request_idol_id"], name: "index_relevance_scores_on_referer_idol_id_and_request_idol_id", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "thumbnail",     limit: 255
    t.string   "original_site", limit: 255
    t.string   "embed_code",    limit: 255
    t.datetime "published_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "channel",       limit: 255
    t.string   "url",           limit: 255
    t.text     "description",   limit: 65535
    t.integer  "pv",            limit: 4,     default: 0
  end

  add_foreign_key "idols_videos", "idols"
  add_foreign_key "idols_videos", "videos"
end
