package draco.tasks

import grails.transaction.Transactional

@Transactional
class TaskService {

    def save(def params, Task task) {
		if(params.crNumbers) {
			if(!task.getCrs()) {
				task.setCrs([] as SortedSet)
			}
			def numbers = params.crNumbers.trim().split(" ")
			numbers.each {
				Cr cr = Cr.findByNumber(it.toUpperCase())
				if(!cr) {
					cr = new Cr(number:it, status:"1")
					cr.save flush:true
				}
				task.getCrs().add(cr)
			}
		}
		
		task.save flush:true
		
		if(params.productItemIds) {
			if(!task.getLogs()) {
				task.setLogs([] as SortedSet)
			}
			def itemIds = params.productItemIds.trim().split(" ")
			itemIds.each {
				Product product = Product.findByItemId(it.toUpperCase())
				def type = "u"
				if(!product) {
					type = "c"
					product = new Product(itemId:it, mode:"a", activate:true)
					product.save flush:true
				}
				
				Log log = Log.findByTaskAndProduct(task, product)
				if(!log) {
					log = new Log(type:type, user:task.getUser(), task:task, product:product)
					log.save flush:true
				}
				task.getLogs().add(log)
			}
		}
		
		if(params.tagNames) {
			if(!task.getTags()) {
				task.setTags([] as SortedSet)
			}
			def names = params.tagNames.trim().split(" ")
			names.each {
				Tag tag = Tag.findByName(it)
				if(!tag) {
					tag = new Tag(name: it)
					tag.save flush:true
				}
				task.getTags().add(tag)
			}
		}
	}

	def prev(Task task) {
		def status = task.getStatus().toInteger()
		status = Math.max(status - 1, 0)
		task.setStatus(status.toString())
		task.getCrs().each {
			if(status > it.getStatus().toInteger()) {
				it.setStatus(status.toString())
			}
		}
		task.save flush:true
    }

	def next(Task task) {
		def status = task.getStatus().toInteger()
		status = Math.min(status + 1, 5)
		task.setStatus(status.toString())
		task.getCrs().each {
			if(status > it.getStatus().toInteger()) {
				it.setStatus(status.toString())
			}
		}
		task.save flush:true
    }
	
	def publish(Task task) {
		task.setStatus("5")
		task.getCrs().each {
			it.setStatus("5")
		}
		task.save flush:true
	}
	
	def removeCr(Task task, def cId) {
		Cr cr = Cr.get(cId)
		task.getCrs().remove(cr)
		task.save flush:true
	}
	
	def removeLog(Task task, def lId) {
		Log log = Log.get(lId)
		Product product = log.getProduct()
		product.getLogs().remove(log)
		task.getLogs().remove(log)
		
		if(log.getType().equals("c")) {
			if(!product.getLogs().isEmpty()) {
				product.getLogs().first()?.setType("c")
			}
		}
		
		product.save flush:true
		task.save flush:true
		log.delete flush:true
	}
	
	def removeTag(Task task, def tId) {
		Tag tag = Tag.get(tId)
		task.getTags().remove(tag)
		task.save flush:true
	}
}
