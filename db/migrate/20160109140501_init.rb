class Init < ActiveRecord::Migration
  def change
    create_users
    create_user_attributes
    create_user_settings
    create_devices

    create_recipes
    create_ingredients
    create_recipe_ingredients
    create_recipe_comments
    create_user_like_recipes
    create_user_clip_recipes

    create_categories
    create_regions
  end

  private
  def create_users
    create_table :users, id: :bigint, unsigned: true do |t|
      t.string :facebook_id, limit: 128, null: false, default: ""
      t.string :name, limit: 100, null: false, default: ""
      t.integer :status, limit: 3, null: false, default: 0
      t.string :encrypted_secret, limit: 255, null: false
      t.timestamps null: false
    end
  end

  def create_user_attributes
    create_table :user_attributes, id: :bigint, unsigned: true do |t|
      t.bigint :user_id, unsigned: true, null: false
      t.string :introduction, limit: 300, null: false
      t.string :url, limit: 255, null: false
      t.integer :region_id, null: false, default: 0
      t.timestamps null: false
    end

    add_index :user_attributes, :user_id
  end

  def create_user_settings
    create_table :user_settings, id: :bigint, unsigned: true do |t|
      t.bigint :user_id, unsigned: true, null: false
      t.integer :key, limit: 3, null: false, default: 0
      t.integer :value, limit: 3, null: false, default: 0
      t.timestamps null: false
    end

    add_index :user_settings, :user_id
  end

  def create_devices
    create_table :devices, id: :bigint, unsigned: true do |t|
      t.bigint :user_id, unsigned: true, null: false
      t.integer :status, limit: 3, null: false, default: 0
      t.string :uuid, limit: 100, null: false, default: ""
      t.string :os, limit: 16, null: false, default: ""
      t.string :os_version, limit: 16, null: false, default: ""
      t.string :model, null: false, default: ""
      t.string :app_version, null: false, default: ""
      t.integer :app_version_code, unsigned: true, null: false, default: 0
      t.string :app_id, limit: 100, null: false, default: ""
      t.string :push_token, limit: 4096
      t.timestamps null: false
    end

    add_index :devices, [:user_id, :os, :uuid, :app_id], unique: true
    add_index :devices, [:user_id, :status]
  end

  def create_recipes
    create_table :recipes, id: :bigint, unsigned: true do |t|
      t.bigint :user_id, unsigned: true, null: false
      t.integer :status, limit: 3, null: false, default: 0
      t.string :title, limit: 100, null: false, default: ""
      t.string :description, limit: 300, null: false, default: ""
      t.integer :category_id, limit: 3, null: false, default: 0

      t.integer :like_num, null: false, default: 0
      t.integer :comment_num, null: false, default: 0
      t.integer :clip_num, null: false, default: 0
      t.timestamps null: false
    end

    add_index :recipes, :user_id
    add_index :recipes, :category_id
  end

  def create_ingredients
    create_table :ingredients, id: :bigint, unsigned: true do |t|
      t.bigint :recipe_id, unsigned: true, null: false
      t.integer :status, limit: 3, null: false, default: 0
      t.string :name, limit: 100, null: false, default: ""
      t.timestamps null: false
    end

    add_index :ingredients, :recipe_id
  end

  def create_recipe_ingredients
    create_table :recipe_ingredients, id: :bigint, unsigned: true do |t|
      t.bigint :recipe_id, unsigned: true, null: false
      t.bigint :ingredient_id, unsigned: true, null: false
      t.timestamps null: false
    end

    add_index :recipe_ingredients, [:recipe_id, :ingredient_id], unique: true
  end

  def create_recipe_comments
    create_table :recipe_comments, id: :bigint, unsigned: true do |t|
      t.bigint :recipe_id, unsigned: true, null: false
      t.bigint :user_id, unsigned: true, null: false
      t.integer :status, limit: 3, null: false, default: 0
      t.string :comment, limit: 255, null: false, default: ""
      t.timestamps null: false
    end

    add_index :recipe_comments, :recipe_id
  end

  def create_user_like_recipes
    create_table :user_like_recipes, id: :bigint, unsigned: true do |t|
      t.bigint :recipe_id, unsigned: true, null: false
      t.bigint :user_id, unsigned: true, null: false
      t.integer :status, limit: 3, null: false, default: 0
      t.timestamps null: false
    end

    add_index :user_like_recipes, :recipe_id
  end

  def create_user_clip_recipes
    create_table :user_clip_recipes, id: :bigint, unsigned: true do |t|
      t.bigint :recipe_id, unsigned: true, null: false
      t.bigint :user_id, unsigned: true, null: false
      t.integer :status, limit: 3, null: false, default: 0
      t.timestamps null: false
    end

    add_index :user_clip_recipes, :recipe_id
  end

  def create_categories
    create_table :categories, id: :int, unsigned: true do |t|
      t.string :name, limit: 100, null: false, default: ""
      t.integer :status, limit: 3, null: false, default: 1
    end
  end

  def create_regions
    create_table :regions, id: :int, unsigned: true do |t|
      t.string :name, limit: 100, null: false, default: ""
      t.integer :status, limit: 3, null: false, default: 1
    end
  end

end
