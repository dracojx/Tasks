package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TaskController {
	
	def crService
	def logService
	def taskService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Task.list(params), model:[taskInstanceCount: Task.count()]
    }

    def show(Task taskInstance) {
        respond taskInstance
    }

    def create() {
        respond new Task(params)
    }

    @Transactional
    def save(Task taskInstance) {
        if (taskInstance == null) {
            notFound()
            return
        }
        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view:'create'
            return
        }
		
		if(params.crNumbers) {
			def crs = crService.createCrs(params.crNumbers)
			taskInstance.setCrs(crs)
		}
        taskInstance.save flush:true
		
		if(params.productItemIds) {
			def logs = logService.createLogByTask(params.productItemIds, taskInstance)
			taskInstance.setLogs(logs)
		}

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
                redirect taskInstance
            }
            '*' { respond taskInstance, [status: CREATED] }
        }
    }

    def edit(Task taskInstance) {
        respond taskInstance
    }

    @Transactional
    def update(Task taskInstance) {
        if (taskInstance == null) {
            notFound()
            return
        }

        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view:'edit'
            return
        }
		
		if(params.crNumbers) {
			def crs = crService.createCrs(params.crNumbers)
			taskInstance.getCrs().addAll(crs)
		}

        taskInstance.save flush:true
		
		if(params.productItemIds) {
			def logs = logService.createLogByTask(params.productItemIds, taskInstance)
			taskInstance.getLogs().addAll(logs)
		}
		
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Task.label', default: 'Task'), taskInstance.id])
                redirect taskInstance
            }
            '*'{ respond taskInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Task taskInstance) {

        if (taskInstance == null) {
            notFound()
            return
        }

        taskInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Task.label', default: 'Task'), taskInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
	
	@Transactional
	def next(Task taskInstance) {
		taskService.next(taskInstance)
		
		taskInstance.save flush:true
		redirect action:"show", id:taskInstance.getId()
	}

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
