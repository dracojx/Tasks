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
			def itemIds = params.productItemIds.split(" ")
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
					log = new Log(type:type, user:User.get(userId), task:task, product:product)
					log.save flush:true
				}
				task.getLogs().add(log)
			}
		}
		
		if(params.tagNames) {
			if(!task.getTags()) {
				task.setTags([] as SortedSet)
			}
			def names = params.tagNames.split(" ")
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
		status--
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
	
	def addTagMulti(def id, def tagNames) {
		if(id && tagNames) {
			def ids = []
			id?.each {
				ids.add(it as long)
			}
			def names = tagNames.split(" ")
			def tags = [] as SortedSet
			names.each {
				def tag = Tag.findByName(it)
				if(!tag) {
					tag = new Tag(name: it)
					tag.save flush:true
					tags.add(tag)
				}
			}
			def tasks = Task.getAll(ids)
			tasks.each {
				it.getTags().addAll(tags)
			}
			Task.saveAll(tasks)
			return tasks.size()
		}
		return 0
	}
	
	def removeTag(Task task, def tId) {
		Tag tag = Tag.get(tId)
		task.getTags().remove(tag)
		task.save flush:true
	}
}
