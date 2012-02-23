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

ActiveRecord::Schema.define(:version => 20120223184208) do

  create_table "annotation_sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "annotations", :force => true do |t|
    t.string   "accession"
    t.string   "desc"
    t.integer  "annotation_source_id"
    t.integer  "interpro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "annotations", ["accession"], :name => "index_annotations_on_accession", :unique => true

  create_table "blast_dbs", :force => true do |t|
    t.string   "display_name"
    t.string   "blast_index_name"
    t.string   "file_name"
    t.string   "organism_name"
    t.integer  "taxonomy_id"
    t.string   "description"
    t.string   "data_type"
    t.integer  "num_seqs"
    t.string   "url"
    t.string   "image"
    t.integer  "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", :force => true do |t|
    t.integer  "sequence_id"
    t.integer  "annotation_id"
    t.integer  "start_pos"
    t.integer  "end_pos"
    t.integer  "frame"
    t.float    "score"
    t.string   "match_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "features", ["annotation_id"], :name => "index_features_on_annotation_id"
  add_index "features", ["sequence_id", "annotation_id"], :name => "index_features_on_sequence_id_and_annotation_id", :unique => true
  add_index "features", ["sequence_id"], :name => "index_features_on_sequence_id"

  create_table "gene_ontologies", :force => true do |t|
    t.string   "accession"
    t.string   "ontology_root"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gene_ontologies", ["accession"], :name => "index_gene_ontologies_on_accession", :unique => true

  create_table "gene_ontologies_interpros", :id => false, :force => true do |t|
    t.integer "interpro_id"
    t.integer "gene_ontology_id"
  end

  add_index "gene_ontologies_interpros", ["gene_ontology_id"], :name => "index_gene_ontologies_interpros_on_gene_ontology_id"
  add_index "gene_ontologies_interpros", ["interpro_id", "gene_ontology_id"], :name => "index_gene_ontologies_interpros_on_interpro_id_gene_ontology_id", :unique => true
  add_index "gene_ontologies_interpros", ["interpro_id"], :name => "index_gene_ontologies_interpros_on_interpro_id"

  create_table "interpros", :force => true do |t|
    t.string   "accession"
    t.string   "desc"
    t.integer  "gene_ontology_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequences", :force => true do |t|
    t.string   "accession"
    t.string   "name"
    t.string   "desc"
    t.text     "na_seq"
    t.integer  "blast_db_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sequences", ["accession", "blast_db_id"], :name => "index_sequences_on_accession_and_blast_db_id", :unique => true
  add_index "sequences", ["accession"], :name => "index_sequences_on_accession"
  add_index "sequences", ["name"], :name => "index_sequences_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.boolean  "enabled",            :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
