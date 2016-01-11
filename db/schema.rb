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

ActiveRecord::Schema.define(version: 20160109140501) do

  create_table "categories", id: :integer, limit: 4, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string  "name",   limit: 100, default: "", null: false
    t.integer "status", limit: 3,   default: 1,  null: false
  end

  create_table "devices", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "user_id",          limit: 8,                 null: false, unsigned: true
    t.integer  "status",           limit: 3,    default: 0,  null: false
    t.string   "uuid",             limit: 100,  default: "", null: false
    t.string   "os",               limit: 16,   default: "", null: false
    t.string   "os_version",       limit: 16,   default: "", null: false
    t.string   "model",            limit: 255,  default: "", null: false
    t.string   "app_version",      limit: 255,  default: "", null: false
    t.integer  "app_version_code", limit: 4,    default: 0,  null: false, unsigned: true
    t.string   "app_id",           limit: 100,  default: "", null: false
    t.string   "push_token",       limit: 4096
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "devices", ["user_id", "os", "uuid", "app_id"], name: "index_devices_on_user_id_and_os_and_uuid_and_app_id", unique: true, using: :btree
  add_index "devices", ["user_id", "status"], name: "index_devices_on_user_id_and_status", using: :btree

  create_table "ingredients", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "status",     limit: 3,   default: 0,  null: false
    t.string   "name",       limit: 100, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "ingredients", ["name"], name: "index_ingredients_on_name", unique: true, using: :btree

  create_table "recipe_comments", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "recipe_id",  limit: 8,                null: false, unsigned: true
    t.integer  "user_id",    limit: 8,                null: false, unsigned: true
    t.integer  "status",     limit: 3,   default: 0,  null: false
    t.string   "comment",    limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "recipe_comments", ["recipe_id"], name: "index_recipe_comments_on_recipe_id", using: :btree

  create_table "recipe_ingredients", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "recipe_id",     limit: 8, null: false, unsigned: true
    t.integer  "ingredient_id", limit: 8, null: false, unsigned: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "recipe_ingredients", ["recipe_id", "ingredient_id"], name: "index_recipe_ingredients_on_recipe_id_and_ingredient_id", unique: true, using: :btree

  create_table "recipes", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "user_id",       limit: 8,                null: false, unsigned: true
    t.integer  "status",        limit: 3,   default: 0,  null: false
    t.string   "title",         limit: 100, default: "", null: false
    t.string   "description",   limit: 300, default: "", null: false
    t.integer  "category_id",   limit: 3,   default: 0,  null: false
    t.integer  "liked_num",     limit: 4,   default: 0,  null: false
    t.integer  "commented_num", limit: 4,   default: 0,  null: false
    t.integer  "cliped_num",    limit: 4,   default: 0,  null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "recipes", ["category_id"], name: "index_recipes_on_category_id", using: :btree
  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "regions", id: :integer, limit: 4, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string  "name",   limit: 100, default: "", null: false
    t.integer "status", limit: 3,   default: 1,  null: false
  end

  create_table "user_attributes", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "user_id",      limit: 8,               null: false, unsigned: true
    t.string   "introduction", limit: 300,             null: false
    t.string   "url",          limit: 255,             null: false
    t.integer  "region_id",    limit: 4,   default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "user_attributes", ["user_id"], name: "index_user_attributes_on_user_id", using: :btree

  create_table "user_clip_recipes", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "recipe_id",  limit: 8,             null: false, unsigned: true
    t.integer  "user_id",    limit: 8,             null: false, unsigned: true
    t.integer  "status",     limit: 3, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "user_clip_recipes", ["recipe_id"], name: "index_user_clip_recipes_on_recipe_id", using: :btree

  create_table "user_like_recipes", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "recipe_id",  limit: 8,             null: false, unsigned: true
    t.integer  "user_id",    limit: 8,             null: false, unsigned: true
    t.integer  "status",     limit: 3, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "user_like_recipes", ["recipe_id"], name: "index_user_like_recipes_on_recipe_id", using: :btree

  create_table "user_settings", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "user_id",    limit: 8,             null: false, unsigned: true
    t.integer  "key",        limit: 3, default: 0, null: false
    t.integer  "value",      limit: 3, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "user_settings", ["user_id"], name: "index_user_settings_on_user_id", using: :btree

  create_table "users", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "facebook_id",      limit: 128, default: "", null: false
    t.string   "name",             limit: 100, default: "", null: false
    t.integer  "status",           limit: 3,   default: 0,  null: false
    t.string   "encrypted_secret", limit: 255,              null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

end
