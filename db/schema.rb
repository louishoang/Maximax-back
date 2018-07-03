# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_180_702_183_227) do
  create_table 'active_storage_attachments', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'brands', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
  end

  create_table 'categories', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'parent_id'
    t.index ['parent_id'], name: 'index_categories_on_parent_id'
  end

  create_table 'friendly_id_slugs', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'slug', null: false
    t.integer 'sluggable_id', null: false
    t.string 'sluggable_type', limit: 50
    t.string 'scope'
    t.datetime 'created_at'
    t.index %w[slug sluggable_type scope], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope', unique: true
    t.index %w[slug sluggable_type], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type'
    t.index ['sluggable_id'], name: 'index_friendly_id_slugs_on_sluggable_id'
    t.index ['sluggable_type'], name: 'index_friendly_id_slugs_on_sluggable_type'
  end

  create_table 'inventories', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'count_on_hand', default: 0
    t.integer 'count_pending_to_customer', default: 0
    t.integer 'count_pending_from_supplier', default: 0
  end

  create_table 'option_types', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', limit: 100
    t.string 'display_name', limit: 100
    t.integer 'position', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_option_types_on_name'
  end

  create_table 'option_value_variants', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'variant_id'
    t.integer 'option_value_id'
    t.index ['option_value_id'], name: 'index_option_value_variants_on_option_value_id'
    t.index %w[variant_id option_value_id], name: 'index_option_value_variants_on_variant_id_and_option_value_id'
  end

  create_table 'option_values', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', limit: 100
    t.string 'display_name', limit: 100
    t.integer 'position', default: 1, null: false
    t.integer 'option_type_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[name display_name], name: 'index_option_values_on_name_and_display_name'
    t.index ['option_type_id'], name: 'index_option_values_on_option_type_id'
    t.index ['position'], name: 'index_option_values_on_position'
  end

  create_table 'product_images', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'product_id', null: false
    t.integer 'position', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['position'], name: 'index_product_images_on_position'
    t.index ['product_id'], name: 'index_product_images_on_product_id'
  end

  create_table 'product_option_types', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'position'
    t.integer 'product_id'
    t.integer 'option_type_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['option_type_id'], name: 'index_product_option_types_on_option_type_id'
    t.index ['position'], name: 'index_product_option_types_on_position'
    t.index ['product_id'], name: 'index_product_option_types_on_product_id'
  end

  create_table 'product_properties', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'product_id', null: false
    t.integer 'property_id', null: false
    t.integer 'position', default: 0
    t.string 'value'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[product_id property_id], name: 'index_product_properties_on_product_id_and_property_id'
  end

  create_table 'products', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.text 'product_keywords'
    t.datetime 'available_at'
    t.datetime 'deleted_at'
    t.string 'meta_keywords'
    t.string 'meta_description'
    t.integer 'category_id', null: false
    t.string 'permalink', null: false
    t.integer 'brand_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['brand_id'], name: 'index_products_on_brand_id'
    t.index ['category_id'], name: 'index_products_on_category_id'
    t.index ['deleted_at'], name: 'index_products_on_deleted_at'
    t.index ['name'], name: 'index_products_on_name'
    t.index ['permalink'], name: 'index_products_on_permalink', unique: true
  end

  create_table 'properties', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'identifying_name', null: false
    t.string 'display_name', null: false
    t.boolean 'active', default: true
  end

  create_table 'users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'authentication_token', limit: 30
    t.datetime 'auth_token_issued_at'
    t.string 'first_name'
    t.string 'last_name'
    t.integer 'role', default: 0
    t.index ['authentication_token'], name: 'index_users_on_authentication_token', unique: true
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['first_name'], name: 'index_users_on_first_name'
    t.index ['last_name'], name: 'index_users_on_last_name'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['role'], name: 'index_users_on_role'
  end

  create_table 'variants', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'product_id', null: false
    t.string 'sku', null: false
    t.string 'name'
    t.decimal 'price', precision: 8, scale: 2, default: '0.0', null: false
    t.decimal 'cost', precision: 8, scale: 2, default: '0.0', null: false
    t.datetime 'deleted_at'
    t.boolean 'master', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'inventory_id'
    t.index ['inventory_id'], name: 'index_variants_on_inventory_id'
    t.index ['product_id'], name: 'index_variants_on_product_id'
    t.index ['sku'], name: 'index_variants_on_sku'
  end
end
