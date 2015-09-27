package draco.tasks

import grails.transaction.Transactional

@Transactional
class LogService {

	def createLogByProduct(def req, def product) {
		def task = Task.findByReq(req)
		if(!task) {
			task = new Task(req: req, status:"0", user:User.getAll().get(0))
			if(!task.save()) {
				task.errors.each { println it }
			}
		}
		def type = product.getLogs()?.size() == 0 ? "c" : "u"
		def log = new Log(type:type, task:task, product:product, updateTime:new Date())
		if(!log.save()) {
			log.errors.each { println it }
		}
	}

	def createLogByTask(def productNumbers, def task) {
		def logs = [] as SortedSet
		def itemIds = productNumbers.split(" ")
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
			def log = new Log(type:type, task:task, product:product, updateTime:new Date())
			if(!log.save()) {
				log.errors.each { 
					println it 
				}
			}
			logs.add(log)
		}
		return logs
	}
}
