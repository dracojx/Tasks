package draco.tasks

import grails.transaction.Transactional

@Transactional
class TagService {
	
	def delete(Tag tag) {
		def products = Product.where {
			tags { id == tag.getId() }
		}
		products.each {
			it.getTags().remove(tag)
			it.save flush:true
		}
		tag.delete flush:true
	}
}
