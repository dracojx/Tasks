package draco.tasks

import grails.transaction.Transactional

@Transactional
class CrService {
	
	def createCrs(def crNumbers) {
		def crs = [] as SortedSet
		def numbers = crNumbers.split(" ")
		numbers.each {
			def cr = Cr.findByNumber(it)
			if(!cr) {
				cr = new Cr(number:it, status:"1")
				if(!cr.save()) {
					cr.errors.each {error->
						println error
					}
				}
			}
			crs.add(cr)
		}
		return crs
	}
	
	def update(def productItemIds) {
		def products = [] as SortedSet
		def itemIds = productItemIds.split(" ")
		itemIds.each {
			def product = Product.findByItemId(it)
			if(!product) {
				product = new Product(itemId:it, mode:"a", activate:true)
				if(!product.save()) {
					product.errors.each {error->
						 println it 
					}
				}
			}
			products.add(product)
		}
		return products
	}
	
	def delete(def cr) {
		def tasks = Task.where {
			crs { id == cr.getId() }
		}
		tasks.each {
			it.getCrs().remove(cr)
			it.save()
		}
	}
	
	def next(def cr) {
		def status = cr.getStatus().toInteger()
		status++
		cr.setStatus(status.toString())
		cr.save flush:true
	}
}
