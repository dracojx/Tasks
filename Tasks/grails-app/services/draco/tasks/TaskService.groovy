package draco.tasks

import grails.transaction.Transactional

@Transactional
class TaskService {

    def save(def params, Task task, def userId) {
		if(params.crNumbers) {
			if(!task.getCrs()) {
				task.setCrs([] as SortedSet)
			}
			def numbers = params.crNumbers.split(" ")
			numbers.each {
				Cr cr = Cr.findByNumber(it)
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
			def itemIds = params.productItemIds.split(" ")
			itemIds.each {
				Product product = Product.findByItemId(it)
				def type = "u"
				if(!product) {
					type = "c"
					product = new Product(itemId:it, mode:"a", activate:true)
					product.save flush:true
				}
				
				Log log = Log.findByTaskAndProduct(task, product)
				if(!log) {
					log = new Log(type:type, user:User.get(userId), task:task, product:product)
					log.save flush:true
				}
				task.getLogs().add(log)
			}
		}
	}

	def next(Task task) {
		def status = task.getStatus().toInteger()
		status++
		task.setStatus(status.toString())
		task.getCrs().each {
			if(status > it.getStatus().toInteger()) {
				it.setStatus(status.toString())
			}
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
		task.getLogs().remove(log)
		task.save flush:true
		log.delete flush:true
	}
}
