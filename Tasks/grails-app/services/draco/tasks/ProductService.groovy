package draco.tasks

import grails.transaction.Transactional

@Transactional
class ProductService {
	
	def save(def params, Product product, def userId) {
        product.save flush:true
		
		if(params.req) {
			Task task = Task.findByReq(params.req)
			if(!task) {
				task = new Task(req: params.req, status:"0", user:User.get(userId))
				task.save flush:true
			}
			
			Log log = Log.findByTaskAndProduct(task, product)
			if(!log) {
				def type = product.getLogs()?.size() > 0 ? "u" : "c"
				log = new Log(type:type, user:User.get(userId), task:task, product:product)
				log.save flush:true
			}
		}
	}

	def removeLog(Product product, def lId) {
		Log log = Log.get(lId)
		product.getLogs().remove(log)
		product.save flush:true
		log.delete flush:true
	}
}
