package draco.tasks

import grails.transaction.Transactional

@Transactional
class CrService {
	
	def save(def params, Cr cr) {
		if(params.productItemIds) {
			if(!cr.getProducts()) {
				cr.setProducts([] as SortedSet)
			}
			def itemIds = params.productItemIds.split(" ")
			itemIds.each {
				Product product = Product.findByItemId(it)
				if(!product) {
					product = new Product(itemId:it, mode:"a", activate:true)
					product.save flush:true
				}
				cr.getProducts().add(product)
			}
		}
		
		cr.save flush:true
	}
	
	def prev(Cr cr) {
		def status = cr.getStatus().toInteger()
		status--
		cr.setStatus(status.toString())
		cr.save flush:true
	}
	
	def next(Cr cr) {
		def status = cr.getStatus().toInteger()
		status++
		cr.setStatus(status.toString())
		cr.save flush:true
	}
	
	def removeProduct(Cr cr, def pId) {
		Product product = Product.get(pId)
		cr.getProducts().remove(product)
		cr.save flush:true
	}

	def delete(Cr cr) {
		def tasks = Task.where {
			crs { id == cr.getId() }
		}
		tasks.each {
			it.getCrs().remove(cr)
			it.save()
		}
		cr.delete flush:true
	}
}
