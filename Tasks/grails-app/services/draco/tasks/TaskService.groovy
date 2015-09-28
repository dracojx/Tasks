package draco.tasks

import grails.transaction.Transactional

@Transactional
class TaskService {

    def next(def task) {
		def status = task.getStatus().toInteger()
		status++
		task.setStatus(status.toString())
		task.getCrs().each {
			if(status > it.getStatus().toInteger()) {
				it.setStatus(status.toString())
			}
		}
    }
}
