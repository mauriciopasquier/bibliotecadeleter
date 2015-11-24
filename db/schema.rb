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

ActiveRecord::Schema.define(version: 20151124032445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"
  enable_extension "hstore"

  create_table "artistas", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug",       null: false
  end

  add_index "artistas", ["nombre"], name: "index_artistas_on_nombre", unique: true, using: :btree
  add_index "artistas", ["slug"], name: "index_artistas_on_slug", unique: true, using: :btree

  create_table "artistas_imagenes", id: false, force: true do |t|
    t.integer "artista_id"
    t.integer "imagen_id"
  end

  add_index "artistas_imagenes", ["artista_id"], name: "index_artistas_imagenes_on_artista_id", using: :btree
  add_index "artistas_imagenes", ["imagen_id"], name: "index_artistas_imagenes_on_imagen_id", using: :btree

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "cartas", force: true do |t|
    t.string   "nombre",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug",       null: false
  end

  add_index "cartas", ["slug"], name: "index_cartas_on_slug", unique: true, using: :btree

  create_table "cartas_formatos", id: false, force: true do |t|
    t.integer "carta_id"
    t.integer "formato_id"
  end

  add_index "cartas_formatos", ["carta_id"], name: "index_cartas_formatos_on_carta_id", using: :btree
  add_index "cartas_formatos", ["formato_id"], name: "index_cartas_formatos_on_formato_id", using: :btree

  create_table "disenos", force: true do |t|
    t.string   "nombre",           null: false
    t.text     "texto"
    t.string   "tipo"
    t.string   "supertipo"
    t.string   "subtipo"
    t.string   "fue"
    t.string   "res"
    t.string   "senda"
    t.text     "ambientacion"
    t.text     "fundamento",       null: false
    t.string   "slug",             null: false
    t.string   "coste"
    t.integer  "coste_convertido"
    t.integer  "usuario_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "expansiones", force: true do |t|
    t.string   "nombre",            null: false
    t.date     "lanzamiento"
    t.date     "presentacion"
    t.text     "notas"
    t.string   "saga"
    t.integer  "total"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "slug",              null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "codigo"
  end

  add_index "expansiones", ["slug"], name: "index_expansiones_on_slug", unique: true, using: :btree

  create_table "expansiones_formatos", id: false, force: true do |t|
    t.integer "expansion_id"
    t.integer "formato_id"
  end

  add_index "expansiones_formatos", ["expansion_id"], name: "index_expansiones_formatos_on_expansion_id", using: :btree
  add_index "expansiones_formatos", ["formato_id"], name: "index_expansiones_formatos_on_formato_id", using: :btree

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

  create_table "formatos", force: true do |t|
    t.string   "nombre",                             null: false
    t.string   "slug",                               null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "demonios",       default: 1
    t.integer  "principal",      default: 50
    t.integer  "suplente",       default: 12
    t.integer  "copias",         default: 4
    t.boolean  "limitar_sendas", default: true
    t.string   "tipo",           default: "Abierto"
  end

  add_index "formatos", ["slug"], name: "index_formatos_on_slug", unique: true, using: :btree

  create_table "imagenes", force: true do |t|
    t.integer  "version_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
    t.boolean  "cara",                 default: true
    t.hstore   "metadatos",            default: {}
  end

  add_index "imagenes", ["version_id"], name: "index_imagenes_on_version_id", using: :btree

  create_table "inscripciones", force: true do |t|
    t.string   "participante", null: false
    t.string   "codigo",       null: false
    t.integer  "torneo_id",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "dropeo"
    t.integer  "desempate",    null: false
  end

  create_table "links", force: true do |t|
    t.string   "url"
    t.integer  "linkeable_id"
    t.string   "linkeable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "nombre"
  end

  add_index "links", ["linkeable_id", "linkeable_type"], name: "index_links_on_linkeable_id_and_linkeable_type", using: :btree

  create_table "listas", force: true do |t|
    t.string   "nombre",                       null: false
    t.integer  "usuario_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "visible",    default: true
    t.string   "type",       default: "Lista"
    t.string   "slug",                         null: false
    t.integer  "mazo_id"
    t.text     "notas"
  end

  add_index "listas", ["mazo_id"], name: "index_listas_on_mazo_id", using: :btree
  add_index "listas", ["slug"], name: "index_listas_on_slug", using: :btree
  add_index "listas", ["usuario_id"], name: "index_listas_on_usuario_id", using: :btree

  create_table "mazos", force: true do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "usuario_id"
    t.string   "nombre"
    t.string   "slug",                               null: false
    t.boolean  "visible",             default: true
    t.integer  "formato_objetivo_id"
    t.text     "notas"
  end

  add_index "mazos", ["slug"], name: "index_mazos_on_slug", using: :btree
  add_index "mazos", ["usuario_id"], name: "index_mazos_on_usuario_id", using: :btree

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "rondas", force: true do |t|
    t.integer  "numero"
    t.integer  "inscripcion_id"
    t.integer  "oponente_id"
    t.integer  "puntos"
    t.integer  "partidas_ganadas"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "sashes", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slots", force: true do |t|
    t.integer  "cantidad"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "inventario_id",   null: false
    t.string   "inventario_type"
    t.integer  "version_id",      null: false
  end

  add_index "slots", ["inventario_id", "inventario_type"], name: "index_slots_on_inventario_id_and_inventario_type", using: :btree
  add_index "slots", ["version_id"], name: "index_slots_on_version_id", using: :btree

  create_table "tiendas", force: true do |t|
    t.string   "nombre",     null: false
    t.string   "direccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tiendas", ["nombre"], name: "index_tiendas_on_nombre", unique: true, using: :btree

  create_table "torneos", force: true do |t|
    t.date     "fecha",          null: false
    t.integer  "tienda_id",      null: false
    t.string   "direccion"
    t.integer  "formato_id",     null: false
    t.integer  "organizador_id", null: false
    t.string   "juez_principal"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "slug",           null: false
    t.string   "estado",         null: false
  end

  add_index "torneos", ["fecha"], name: "index_torneos_on_fecha", using: :btree
  add_index "torneos", ["organizador_id"], name: "index_torneos_on_organizador_id", using: :btree
  add_index "torneos", ["slug"], name: "index_torneos_on_slug", using: :btree
  add_index "torneos", ["tienda_id"], name: "index_torneos_on_tienda_id", using: :btree

  create_table "usuarios", force: true do |t|
    t.string   "nick",                                              null: false
    t.string   "email",                  default: "",               null: false
    t.string   "encrypted_password",     default: "",               null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "slug"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
    t.string   "codigo"
    t.string   "nombre"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "forem_admin",            default: false
    t.string   "forem_state",            default: "pending_review"
    t.boolean  "forem_auto_subscribe",   default: false
  end

  add_index "usuarios", ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true, using: :btree
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["nick"], name: "index_usuarios_on_nick", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  add_index "usuarios", ["slug"], name: "index_usuarios_on_slug", unique: true, using: :btree
  add_index "usuarios", ["unlock_token"], name: "index_usuarios_on_unlock_token", unique: true, using: :btree

  create_table "versiones", force: true do |t|
    t.text     "texto"
    t.string   "tipo"
    t.string   "supertipo"
    t.string   "subtipo"
    t.string   "fue"
    t.string   "res"
    t.string   "senda"
    t.text     "ambientacion"
    t.integer  "numero"
    t.string   "rareza"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "carta_id"
    t.boolean  "canonica",         default: false
    t.integer  "expansion_id"
    t.string   "slug",                             null: false
    t.string   "coste"
    t.integer  "coste_convertido"
  end

  add_index "versiones", ["carta_id"], name: "index_versiones_on_carta_id", using: :btree
  add_index "versiones", ["expansion_id"], name: "index_versiones_on_expansion_id", using: :btree

end
