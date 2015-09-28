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
				cr = new Cr(number:it, status:"0")
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
	
	def updateCr(def productNumbers) {
		def products = []
		def itemIds = productNumbers.split(" ")
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
}
