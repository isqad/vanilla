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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131008090201) do

  create_table "discussions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "owner_id",                          :null => false
    t.integer  "friend_id",                         :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "state",      :default => "pending"
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["owner_id"], :name => "index_friendships_on_owner_id"
  add_index "friendships", ["state"], :name => "index_friendships_on_state"

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "messages", ["discussion_id"], :name => "index_messages_on_discussion_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "notifications", :force => true do |t|
    t.text     "notify",     :null => false
    t.integer  "user_id"
    t.integer  "from_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notifications", ["from_id"], :name => "index_notifications_on_from_id"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "photos", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "image_meta"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
    t.integer  "user_id"
  end

  add_index "posts", ["author_id"], :name => "index_posts_on_author_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "profiles", :force => true do |t|
    t.string  "first_name", :default => "",     :null => false
    t.string  "last_name",  :default => "",     :null => false
    t.integer "user_id"
    t.date    "birthday"
    t.string  "gender",     :default => "male", :null => false
    t.integer "photo_id"
    t.text    "bio",        :default => "",     :null => false
  end

  add_index "profiles", ["photo_id"], :name => "index_profiles_on_photo_id"
  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "speakers", :force => true do |t|
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "speakers", ["discussion_id"], :name => "index_speakers_on_discussion_id"
  add_index "speakers", ["user_id"], :name => "index_speakers_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",              :default => "", :null => false
    t.string   "username"
    t.string   "encrypted_password", :default => "", :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "last_response_at"
    t.string   "persistence_token",                  :null => false
    t.string   "perishable_token",   :default => "", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
