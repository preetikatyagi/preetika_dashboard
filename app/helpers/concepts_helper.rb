module ConceptsHelper

	def render_concept_tree(concept)
		children = concept.child_subconcepts
		out = '<ul>'
		out += link_to(h(concept.name), concept)
		if concept.members.count > 0
			out += ' ('
			out += concept.members.collect {|m| link_to(h(m.gene.hugo_id), m.gene) }.join(', ')
			out += ')'
		end
		if concept.treatments.count > 0
			out += ' ('
			out += concept.treatments.collect {|i| link_to(h(i.drug.name), i.drug) }.join(', ')
			out += ')'
		end
		
		children.each do |i|
			out += '<li>'
			out += render_concept_tree(i.child)
			out += '</li>'
		end
		out += '</ul>'
		out
	end
	
end
