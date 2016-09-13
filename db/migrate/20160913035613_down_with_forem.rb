class DownWithForem < ActiveRecord::Migration
  def up
    # Drop table remueve indices y otros metadatos asociados
    drop_table :forem_categories, if_exists: true, force: true
    drop_table :forem_forums, if_exists: true, force: true
    drop_table :forem_groups, if_exists: true, force: true
    drop_table :forem_memberships, if_exists: true, force: true
    drop_table :forem_posts, if_exists: true, force: true
    drop_table :forem_moderator_groups, if_exists: true, force: true
    drop_table :forem_subscriptions, if_exists: true, force: true
    drop_table :forem_topics, if_exists: true, force: true
    drop_table :forem_views, if_exists: true, force: true
  end

  # Copiado de db:schema
  def down
    create_table "forem_categories", force: true do |t|
      t.string   "name",                   null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "slug"
      t.integer  "position",   default: 0
    end

    add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true, using: :btree

    create_table "forem_forums", force: true do |t|
      t.string  "name"
      t.text    "description"
      t.integer "category_id"
      t.integer "views_count", default: 0
      t.string  "slug"
      t.integer "position",    default: 0
    end

    add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true, using: :btree

    create_table "forem_groups", force: true do |t|
      t.string "name"
    end

    add_index "forem_groups", ["name"], name: "index_forem_groups_on_name", using: :btree

    create_table "forem_memberships", force: true do |t|
      t.integer "group_id"
      t.integer "member_id"
    end

    add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id", using: :btree

    create_table "forem_moderator_groups", force: true do |t|
      t.integer "forum_id"
      t.integer "group_id"
    end

    add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id", using: :btree

    create_table "forem_posts", force: true do |t|
      t.integer  "topic_id"
      t.text     "text"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "reply_to_id"
      t.string   "state",       default: "pending_review"
      t.boolean  "notified",    default: false
    end

    add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id", using: :btree
    add_index "forem_posts", ["state"], name: "index_forem_posts_on_state", using: :btree
    add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id", using: :btree
    add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id", using: :btree

    create_table "forem_subscriptions", force: true do |t|
      t.integer "subscriber_id"
      t.integer "topic_id"
    end

    create_table "forem_topics", force: true do |t|
      t.integer  "forum_id"
      t.integer  "user_id"
      t.string   "subject"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "locked",       default: false,            null: false
      t.boolean  "pinned",       default: false
      t.boolean  "hidden",       default: false
      t.datetime "last_post_at"
      t.string   "state",        default: "pending_review"
      t.integer  "views_count",  default: 0
      t.string   "slug"
    end

    add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id", using: :btree
    add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true, using: :btree
    add_index "forem_topics", ["state"], name: "index_forem_topics_on_state", using: :btree
    add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id", using: :btree

    create_table "forem_views", force: true do |t|
      t.integer  "user_id"
      t.integer  "viewable_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "count",             default: 0
      t.string   "viewable_type"
      t.datetime "current_viewed_at"
      t.datetime "past_viewed_at"
    end

    add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at", using: :btree
    add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id", using: :btree
    add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id", using: :btree
  end
end
