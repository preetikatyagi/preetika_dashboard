class CreateSamples < ActiveRecord::Migration
  def self.up
	
	# Based on sample data provided from David Craig in early April, 2010, the column in import files look like this..
	# chr # We'll ditch this in favor of a "chromosome_id" field that links to an actual chromosome record.
	# loc
	# geneName
	# type # This will cause problems, so we'll rename the field to "kind".
	# dbSNP
	# refAllele
	# snpCode
	# strand
	# depth
	# transcriptID
	# geneID # We'll preserve this as "hugo_id" instead, and use a "gene_id" column as a foreign key to an actual gene record.
	# startCodonLoc
	# distToExon
	# codonSeq
	# oldAA
	# newSeqs
	# newAA
	# nsORss
	# zygosity
	
    create_table :samples do |t|
		t.integer	:upload_id			, :null => false
		t.integer	:chromosome_id		, :null => false
		t.integer	:gene_id			, :null => true
		t.integer	:zygosity_id		, :null => false
		t.integer	:sample_type_id		, :null => false
		t.integer	:loc				, :null => false
		t.string	:gene_name			, :null => true, :limit => 20 # 17 based on `select max(length(gene_name)) from samples`
		t.string	:db_snp				, :null => true, :limit => 255 # 212 based on `select max(length(db_snp)) from samples`
		t.string	:ref_allele			, :null => false, :limit => 1 # G, A, T or C
		t.string	:snp_code			, :null => false, :limit => 4 # 3 based on `select max(length(snp_code)) from samples`
		t.boolean	:strand_add # '+' or '-' in the data.
		t.integer	:depth           , :null => false
		t.string	:transcript_id    , :null => false, :limit => 20 # 18 based on `select max(length(transcript_id)) from samples'
		t.string	:hugo_id         , :null => true, :limit => 20 # 18 based on `select max(length(hugo_id)) from samples`
		t.integer	:start_codon_loc , :null => true
		t.integer	:dist_to_exon    , :null => false
		t.string	:codon_seq       , :null => true, :limit => 16 # 68 possible values based on the sample data.
		t.string	:old_aa          , :null => true, :limit => 1 # null T G R E V N S P Q A L F D H C M Y I K W X
		t.string	:new_seqs        , :null => true, :limit => 4 # 68 possible values based on the sample data.
		t.string	:new_aa          , :null => true, :limit => 1 # null I S T R H A C N E Q P G L V F D W X M Y K
		t.string	:ns_or_ss        , :null => true, :limit => 16 # null nsSNP ssSNP
      t.timestamps
	end

	add_index	:samples, :chromosome_id
	add_index	:samples, :gene_id
	add_index	:samples, :upload_id
  end

  def self.down
	remove_index	:samples, :chromosome_id
	remove_index	:samples, :gene_id
	remove_index	:samples, :upload_id
    drop_table :samples
  end

end
