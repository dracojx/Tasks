package draco.tasks

import grails.transaction.Transactional

@Transactional
class LogService {

	def createLogByProduct(def req, def product, def userId) {
		def task = Task.findByReq(req)
		if(!task) {
			task = new Task(req: req, status:"0", user:User.get(userId))
			if(!task.save()) {
				task.errors.each { println it }
			}
		}
		def log = Log.findByTaskAndProduct(task, product)
		if(!log) {
			def type = product.getLogs()?.size() > 0 ? "u" : "c"
			log = new Log(type:type, task:task, product:product, updateTime:new Date())
			if(!log.save()) {
				log.errors.each { println it }
			}
		}
	}

	def createLogByTask(def productItemIds, def task) {
		def logs = [] as SortedSet
		def itemIds = productItemIds.split(" ")
		itemIds.each {
			def product = Product.findByItemId(it)
			def type = "u"
			if(!product) {
				product = new Product(itemId:it, mode:"a", activate:true)
				if(!product.save()) {
					product.errors.each {error->
						 println it 
					}
				}
				type = "c"
			}
			
			def log = Log.findByTaskAndProduct(task, product)
			if(!log) {
				log = new Log(type:type, task:task, product:product, updateTime:new Date())
				if(!log.save()) {
					log.errors.each { 
						println it 
					}
				}
			}
			logs.add(log)
		}
		return logs
	}
}
