# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100511232444) do

  create_table "aberrations", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "analyses", :force => true do |t|
    t.integer  "analyst_id", :null => false
    t.integer  "import_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chromosomes", :force => true do |t|
    t.integer  "number",      :null => false
    t.string   "import_code", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chromosomes", ["import_code"], :name => "index_chromosomes_on_import_code"

  create_table "concepts", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "aberration_id",  :default => 0, :null => false
    t.integer  "orientation_id", :default => 0, :null => false
    t.integer  "phenotype_id",   :default => 0, :null => false
    t.integer  "pubmed_id"
    t.string   "notes"
    t.integer  "source_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",                   :default => 0
    t.integer  "attempts",                   :default => 0
    t.text     "handler"
    t.string   "last_error", :limit => 1023
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], :name => "index_delayed_jobs_on_locked_by"

  create_table "drugs", :force => true do |t|
    t.string   "name",                                     :null => false
    t.integer  "source_id",                                :null => false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "external_id"
    t.string   "brand_names"
    t.string   "generic_names"
    t.string   "chemical_formula"
    t.string   "absorption"
    t.string   "drug_interactions"
    t.string   "kegg_drug_id"
    t.string   "lims_drug_id"
    t.string   "pubchem_compound_id"
    t.string   "pubchem_substance_id"
    t.string   "genbank_id"
    t.string   "dpd_drug_id"
    t.string   "drug_type"
    t.string   "primary_accession_number"
    t.string   "secondary_accession_number"
    t.string   "chemical_iupac_name"
    t.string   "cas_registry_number"
    t.string   "kegg_compound_id"
    t.string   "chebi_id"
    t.string   "rxlist_link"
    t.string   "pharm_gkb_id"
    t.string   "pdrhealth_link"
    t.string   "wikipedia_link"
    t.string   "drug_category"
    t.string   "pharmacology"
    t.string   "mechanism_of_action"
    t.string   "indication"
    t.string   "atc_codes",                  :limit => 64
  end

  add_index "drugs", ["brand_names"], :name => "index_drugs_on_brand_names"
  add_index "drugs", ["generic_names"], :name => "index_drugs_on_generic_names"

  create_table "formats", :force => true do |t|
    t.string   "name"
    t.string   "mime_type"
    t.string   "file_suffix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genes", :force => true do |t|
    t.string   "hugo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "entrez_id"
    t.string   "ensembl_id", :limit => 32
  end

  add_index "genes", ["ensembl_id"], :name => "index_genes_on_ensembl_id"

  create_table "imports", :force => true do |t|
    t.integer  "importer_id", :null => false
    t.integer  "patient_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.integer  "gene_id",    :null => false
    t.integer  "concept_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orientations", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phenotypes", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "code", :limit => 16, :null => false
    t.string "name", :limit => 16, :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "sample_types", :force => true do |t|
    t.string   "import_code", :limit => 16, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "samples", :force => true do |t|
    t.integer  "upload_id",                     :null => false
    t.integer  "chromosome_id",                 :null => false
    t.integer  "gene_id"
    t.integer  "zygosity_id",                   :null => false
    t.integer  "sample_type_id",                :null => false
    t.integer  "loc",                           :null => false
    t.string   "gene_name",       :limit => 20
    t.string   "db_snp"
    t.string   "ref_allele",      :limit => 1,  :null => false
    t.string   "snp_code",        :limit => 4,  :null => false
    t.boolean  "strand_add"
    t.integer  "depth",                         :null => false
    t.string   "transcript_id",   :limit => 20, :null => false
    t.string   "ensembl_id",      :limit => 20
    t.integer  "start_codon_loc"
    t.integer  "dist_to_exon",                  :null => false
    t.string   "codon_seq",       :limit => 16
    t.string   "old_aa",          :limit => 1
    t.string   "new_seqs",        :limit => 4
    t.string   "new_aa",          :limit => 1
    t.string   "ns_or_ss",        :limit => 16
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "samples", ["chromosome_id"], :name => "index_samples_on_chromosome_id"
  add_index "samples", ["ensembl_id"], :name => "index_samples_on_ensembl_id"
  add_index "samples", ["gene_id"], :name => "index_samples_on_gene_id"
  add_index "samples", ["upload_id"], :name => "index_samples_on_upload_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sources", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description", :null => false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "subconcepts", :force => true do |t|
    t.integer  "parent_id",  :null => false
    t.integer  "child_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", :force => true do |t|
    t.integer  "analysis_id",  :null => false
    t.integer  "treatment_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "treatments", :force => true do |t|
    t.integer  "concept_id",                :null => false
    t.integer  "drug_id",                   :null => false
    t.integer  "weight",     :default => 0
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", :force => true do |t|
    t.integer  "import_id",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "zygosities", :force => true do |t|
    t.string   "import_code", :limit => 16, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
