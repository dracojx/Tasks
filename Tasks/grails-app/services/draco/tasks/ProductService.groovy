package draco.tasks

import grails.transaction.Transactional

@Transactional
class ProductService {
	
	def save(def params, Product product, def userId) {
        product.save flush:true
		
		if(params.tagNames) {
			if(!product.getTags()) {
				product.setTags([] as SortedSet)
			}
			def names = params.tagNames.split(" ")
			names.each {
				Tag tag = Tag.findByName(it)
				if(!tag) {
					tag = new Tag(name: it)
					tag.save flush:true
				}
				product.getTags().add(tag)
			}
		}
		
		if(params.taskReq) {
			Task task = Task.findByReq(params.taskReq.toUpperCase())
			if(!task) {
				def date = new Date()
				task = new Task(req: params.taskReq, status:"0", user:User.get(userId), createDate:date, updateDate:date)
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
		if(log.getType().equals("c")) {
			if(!product.getLogs().isEmpty()) {
				product.getLogs().first().setType("c")
			}
		}
		product.save flush:true
		log.delete flush:true
	}

	def removeTag(Product product, def tId) {
		Tag tag = Tag.get(tId)
		product.getTags().remove(tag)
		product.save flush:true
	}
}
