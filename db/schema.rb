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

ActiveRecord::Schema.define(:version => 20131007235525) do

  create_table "artistas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug",       :null => false
  end

  add_index "artistas", ["slug"], :name => "index_artistas_on_slug", :unique => true

  create_table "artistas_imagenes", :id => false, :force => true do |t|
    t.integer "artista_id"
    t.integer "imagen_id"
  end

  add_index "artistas_imagenes", ["artista_id"], :name => "index_artistas_imagenes_on_artista_id"
  add_index "artistas_imagenes", ["imagen_id"], :name => "index_artistas_imagenes_on_imagen_id"

  create_table "badges_sashes", :force => true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", :default => false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], :name => "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], :name => "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], :name => "index_badges_sashes_on_sash_id"

  create_table "cartas", :force => true do |t|
    t.string   "nombre",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug",       :null => false
  end

  add_index "cartas", ["slug"], :name => "index_cartas_on_slug", :unique => true

  create_table "expansiones", :force => true do |t|
    t.string   "nombre",       :null => false
    t.date     "lanzamiento"
    t.date     "presentacion"
    t.text     "notas"
    t.string   "saga"
    t.integer  "total"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "slug",         :null => false
  end

  add_index "expansiones", ["slug"], :name => "index_expansiones_on_slug", :unique => true

  create_table "expansiones_formatos", :id => false, :force => true do |t|
    t.integer "expansion_id"
    t.integer "formato_id"
  end

  add_index "expansiones_formatos", ["expansion_id"], :name => "index_expansiones_formatos_on_expansion_id"
  add_index "expansiones_formatos", ["formato_id"], :name => "index_expansiones_formatos_on_formato_id"

  create_table "formatos", :force => true do |t|
    t.string   "nombre",     :null => false
    t.string   "slug",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "formatos", ["slug"], :name => "index_formatos_on_slug", :unique => true

  create_table "imagenes", :force => true do |t|
    t.integer  "version_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "archivo_file_name"
    t.string   "archivo_content_type"
    t.integer  "archivo_file_size"
    t.datetime "archivo_updated_at"
  end

  add_index "imagenes", ["version_id"], :name => "index_imagenes_on_version_id"

  create_table "links", :force => true do |t|
    t.string   "url"
    t.integer  "linkeable_id"
    t.string   "linkeable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "nombre"
  end

  add_index "links", ["linkeable_id", "linkeable_type"], :name => "index_links_on_linkeable_id_and_linkeable_type"

  create_table "listas", :force => true do |t|
    t.string   "nombre",                          :null => false
    t.integer  "usuario_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "visible",    :default => true
    t.string   "type",       :default => "Lista"
    t.string   "slug",                            :null => false
    t.integer  "mazo_id"
  end

  add_index "listas", ["mazo_id"], :name => "index_listas_on_mazo_id"
  add_index "listas", ["slug"], :name => "index_listas_on_slug"
  add_index "listas", ["usuario_id"], :name => "index_listas_on_usuario_id"

  create_table "mazos", :force => true do |t|
    t.string   "formato"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "usuario_id"
    t.string   "nombre"
    t.string   "slug",                               :null => false
    t.boolean  "visible",          :default => true
    t.integer  "formato_objetivo"
  end

  add_index "mazos", ["slug"], :name => "index_mazos_on_slug"
  add_index "mazos", ["usuario_id"], :name => "index_mazos_on_usuario_id"

  create_table "merit_actions", :force => true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    :default => false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "merit_activity_logs", :force => true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", :force => true do |t|
    t.integer  "score_id"
    t.integer  "num_points", :default => 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", :force => true do |t|
    t.integer "sash_id"
    t.string  "category", :default => "default"
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sashes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "slots", :force => true do |t|
    t.integer  "cantidad"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "inventario_id"
    t.string   "inventario_type"
    t.integer  "version_id"
  end

  add_index "slots", ["inventario_id", "inventario_type"], :name => "index_slots_on_inventario_id_and_inventario_type"
  add_index "slots", ["version_id"], :name => "index_slots_on_version_id"

  create_table "usuarios", :force => true do |t|
    t.string   "nick",                                   :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "slug"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "sash_id"
    t.integer  "level",                  :default => 0
    t.string   "codigo"
    t.string   "nombre"
  end

  add_index "usuarios", ["confirmation_token"], :name => "index_usuarios_on_confirmation_token", :unique => true
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["nick"], :name => "index_usuarios_on_nick", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true
  add_index "usuarios", ["slug"], :name => "index_usuarios_on_slug", :unique => true
  add_index "usuarios", ["unlock_token"], :name => "index_usuarios_on_unlock_token", :unique => true

  create_table "versiones", :force => true do |t|
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
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "carta_id"
    t.boolean  "canonica",         :default => false
    t.integer  "expansion_id"
    t.string   "slug",                                :null => false
    t.string   "coste"
    t.integer  "coste_convertido"
  end

  add_index "versiones", ["carta_id"], :name => "index_versiones_on_carta_id"
  add_index "versiones", ["expansion_id"], :name => "index_versiones_on_expansion_id"

end
