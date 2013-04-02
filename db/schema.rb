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

ActiveRecord::Schema.define(:version => 20130319235131) do

  create_table "annotation_sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "annotations", :force => true do |t|
    t.string   "accession"
    t.string   "description"
    t.integer  "annotation_source_id"
    t.integer  "interpro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "annotations", ["accession"], :name => "index_annotations_on_accession", :unique => true

  create_table "auto1h_fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.integer  "de_datum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auto1h_fold_changes", ["de_datum_id", "treatment_id", "de_analysis_id", "sequence_id", "base_treatment_id"], :name => "index_h1a_de_data_to_fc", :unique => true
  add_index "auto1h_fold_changes", ["sequence_id", "de_analysis_id", "treatment_id", "base_treatment_id"], :name => "index_auto1h_fold_changes", :unique => true

  create_table "auto1h_r2_fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.integer  "de_datum_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "auto1h_r2_fold_changes", ["de_datum_id", "treatment_id", "de_analysis_id", "sequence_id", "base_treatment_id"], :name => "index_a1hr2_de_data_to_fc", :unique => true
  add_index "auto1h_r2_fold_changes", ["sequence_id", "de_analysis_id", "treatment_id", "base_treatment_id"], :name => "index_auto1h_r2_fold_changes", :unique => true

  create_table "auto24h_fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.integer  "de_datum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auto24h_fold_changes", ["de_datum_id", "treatment_id", "de_analysis_id", "sequence_id", "base_treatment_id"], :name => "index_h24a_de_data_to_fc", :unique => true
  add_index "auto24h_fold_changes", ["sequence_id", "de_analysis_id", "treatment_id", "base_treatment_id"], :name => "index_auto24h_fold_changes", :unique => true

  create_table "auto24h_r2_fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.integer  "de_datum_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "auto24h_r2_fold_changes", ["de_datum_id", "treatment_id", "de_analysis_id", "sequence_id", "base_treatment_id"], :name => "index_a24hr2_de_data_to_fc", :unique => true
  add_index "auto24h_r2_fold_changes", ["sequence_id", "de_analysis_id", "treatment_id", "base_treatment_id"], :name => "index_auto24h_r2_fold_changes", :unique => true

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

  create_table "de_analyses", :force => true do |t|
    t.string   "analysis_method"
    t.string   "script_name"
    t.integer  "experiment_id"
    t.integer  "default_treatment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "de_analyses", ["script_name"], :name => "index_de_analyses_on_script_name", :unique => true

  create_table "de_data", :force => true do |t|
    t.float    "abundance"
    t.integer  "sequence_id"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "de_data", ["sequence_id", "treatment_id", "de_analysis_id"], :name => "index_de_data", :unique => true

  create_table "experiments", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experiments", ["name"], :name => "index_experiments_on_name", :unique => true

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
  add_index "features", ["sequence_id", "annotation_id", "start_pos", "end_pos"], :name => "index_features_unique_feature", :unique => true
  add_index "features", ["sequence_id"], :name => "index_features_on_sequence_id"

  create_table "fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fold_changes", ["sequence_id", "treatment_id", "base_treatment_id"], :name => "index_fold_changes", :unique => true
  add_index "fold_changes", ["sequence_id", "treatment_id", "base_treatment_id"], :name => "index_hetero1h_fold_changes", :unique => true

  create_table "gene_ontologies", :force => true do |t|
    t.string   "accession"
    t.string   "ontology_root"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gene_ontologies", ["accession"], :name => "index_gene_ontologies_on_accession", :unique => true

  create_table "gene_ontologies_interpros", :id => false, :force => true do |t|
    t.integer "gene_ontology_id"
    t.integer "interpro_id"
  end

  add_index "gene_ontologies_interpros", ["gene_ontology_id"], :name => "index_gene_ontologies_interpros_on_gene_ontology_id"
  add_index "gene_ontologies_interpros", ["interpro_id", "gene_ontology_id"], :name => "index_gene_ontologies_interpros_on_interpro_id_gene_ontology_id", :unique => true
  add_index "gene_ontologies_interpros", ["interpro_id"], :name => "index_gene_ontologies_interpros_on_interpro_id"

  create_table "go_slim_sequences", :force => true do |t|
    t.integer  "sequence_id"
    t.integer  "gene_ontology_id"
    t.integer  "go_slim_id"
    t.integer  "go_seq_accession"
    t.string   "go_seq_description"
    t.string   "gene_symbol"
    t.integer  "taxon"
    t.string   "evidence_code"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "go_slim_sequences", ["gene_ontology_id", "go_slim_id", "sequence_id"], :name => "index_go_slim_seqs", :unique => true
  add_index "go_slim_sequences", ["gene_ontology_id", "go_slim_id"], :name => "index_go_slim_sequences_on_gene_ontology_id_and_go_slim_id"
  add_index "go_slim_sequences", ["gene_ontology_id"], :name => "index_go_slim_sequences_on_gene_ontology_id"
  add_index "go_slim_sequences", ["sequence_id", "go_slim_id"], :name => "index_go_slim_sequences_on_sequence_id_and_go_slim_id"
  add_index "go_slim_sequences", ["sequence_id"], :name => "index_go_slim_sequences_on_sequence_id"

  create_table "go_slims", :force => true do |t|
    t.string   "subset"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hetero1h_fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.integer  "de_datum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hetero1h_fold_changes", ["de_datum_id", "treatment_id", "de_analysis_id", "sequence_id", "base_treatment_id"], :name => "index_h1h_de_data_to_fc", :unique => true
  add_index "hetero1h_fold_changes", ["sequence_id", "de_analysis_id", "treatment_id", "base_treatment_id"], :name => "index_hetero1h_fold_changes", :unique => true

  create_table "hetero1h_r2_fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.integer  "de_datum_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "hetero1h_r2_fold_changes", ["de_datum_id", "treatment_id", "de_analysis_id", "sequence_id", "base_treatment_id"], :name => "index_h1hr2_de_data_to_fc", :unique => true
  add_index "hetero1h_r2_fold_changes", ["sequence_id", "de_analysis_id", "treatment_id", "base_treatment_id"], :name => "index_hetero1h_r2_fold_changes", :unique => true

  create_table "hetero24h_fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.integer  "de_datum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hetero24h_fold_changes", ["de_datum_id", "treatment_id", "de_analysis_id", "sequence_id", "base_treatment_id"], :name => "index_h24h_de_data_to_fc", :unique => true
  add_index "hetero24h_fold_changes", ["sequence_id", "de_analysis_id", "treatment_id", "base_treatment_id"], :name => "index_hetero24h_fold_changes", :unique => true

  create_table "hetero24h_r2_fold_changes", :force => true do |t|
    t.float    "log2fc"
    t.float    "fdr"
    t.float    "pval"
    t.integer  "de_analysis_id"
    t.integer  "treatment_id"
    t.integer  "base_treatment_id"
    t.integer  "sequence_id"
    t.integer  "de_datum_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "hetero24h_r2_fold_changes", ["de_datum_id", "treatment_id", "de_analysis_id", "sequence_id", "base_treatment_id"], :name => "index_h24hr2_de_data_to_fc", :unique => true
  add_index "hetero24h_r2_fold_changes", ["sequence_id", "de_analysis_id", "treatment_id", "base_treatment_id"], :name => "index_hetero24h_r2_fold_changes", :unique => true

  create_table "interpros", :force => true do |t|
    t.string   "accession"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaders", :force => true do |t|
    t.integer  "experiment_id"
    t.integer  "treatment_id"
    t.integer  "blast_db_id"
    t.string   "read_seq"
    t.string   "leader_seq"
    t.integer  "leader_len"
    t.integer  "start_pos"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "leaders", ["experiment_id", "blast_db_id", "treatment_id", "read_seq"], :name => "index_experiment_id_treatment_id_blast_db_id_read", :unique => true

  create_table "leaders_sequences", :id => false, :force => true do |t|
    t.integer "leader_id"
    t.integer "sequence_id"
  end

  add_index "leaders_sequences", ["leader_id", "sequence_id"], :name => "index_leader_on_sequence", :unique => true
  add_index "leaders_sequences", ["leader_id"], :name => "index_leaders_sequences_on_leader_id"
  add_index "leaders_sequences", ["sequence_id"], :name => "index_leaders_sequences_on_sequence_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequences", :force => true do |t|
    t.string   "accession"
    t.string   "name"
    t.string   "description"
    t.text     "na_seq"
    t.integer  "blast_db_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sequences", ["accession", "blast_db_id"], :name => "index_sequences_on_accession_and_blast_db_id", :unique => true
  add_index "sequences", ["accession"], :name => "index_sequences_on_accession"
  add_index "sequences", ["name"], :name => "index_sequences_on_name"

  create_table "treatments", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "ordering"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "treatments", ["name"], :name => "index_treatments_on_name"

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
