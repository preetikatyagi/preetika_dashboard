require 'idclight'

module GeneTools
  
  def populate_gene_entrez_ids
    genes = Gene.all(:conditions => 'hugo_id IS NOT NULL AND entrez_id IS NULL')
    stats[:not_found] = 0
    stats[:found] = 0
    genes.each do |g|
      entrez = IDConverter::Light.hugo_id_to_entrez_id(g.hugo_id)
      if entrez.nil?
        stats[:not_found] += 1
      else
        g.entrez_id = entrez
        g.save!
        stats[:found] += 1
      end
    end
    stats
  end
  
end