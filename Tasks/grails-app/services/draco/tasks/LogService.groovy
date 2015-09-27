package draco.tasks

import grails.transaction.Transactional

@Transactional
class LogService {

    def createLog(def type, def req, def product) {
		println "createLog $type $req"
		def task = Task.findByReq(req)
		if(task) {
			def log = new Log(type:type, task:task, product:product, updateTime:new Date())
			if(!log.save()) {
				log.errors.each {
					println it
				}
			}
		}
    }
}
