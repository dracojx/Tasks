package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import org.hibernate.Criteria
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
class TaskController {
	
	def crService
	def logService
	def taskService

    static allowedMethods = [save: "POST", update: "PUT"]
	
	def beforeInterceptor = {
		println "====================================="
		params.entrySet().each {
			println it
		}
		println "====================================="
	}

    def index() {
		params.sort = params.sort ?: 'req'
		params.order = params.order ?: 'desc'
        respond Task.list(params)
    }
	
	def search() {
		if(params.keyword?.trim()) {
			def keyword = params.keyword.trim()
			def results = Task.withCriteria {
				order(params.sort?:'req', params.order?:'desc')
				createAlias('crs', 'c', CriteriaSpecification.LEFT_JOIN)
				createAlias('tags', 't', CriteriaSpecification.LEFT_JOIN)
				createAlias('logs', 'l', CriteriaSpecification.LEFT_JOIN)
				setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				or {
					ilike('req', "%$keyword%")
					ilike('title', "%$keyword%")
					ilike('remark', "%$keyword%")
					ilike('c.number', keyword)
					ilike('t.name', keyword)
					eq('l.product', Product.findByItemIdIlike(keyword))
				}
			}
			render view:'index', model:[taskInstanceList: results, action: 'search', keyword: keyword]
		} else {
			flash.message = flash.message
			redirect action: 'index', params: [sort: params.sort, order: params.order]
		}
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
		def logs = taskService.save(params, taskInstance, session.userId)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: ['', taskInstance.getReq()])
	            redirect action: 'edit', id: taskInstance.getId()
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
		
		taskInstance.setUpdateTime(new Date())
		def logs = taskService.save(params, taskInstance, session.userId)
		
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: ['', taskInstance.getReq()])
                redirect action: 'edit', id: taskInstance.getId()
            }
            '*'{ respond taskInstance, [status: OK] }
        }
    }

    @Transactional
	def delete(Task taskInstance) {
		taskInstance.setActivate(false)
		taskInstance.setUpdateTime(new Date())
		taskInstance.save flush:true
	    flash.message = message(code: 'task.closed.message', args: [taskInstance.getReq()])
		redirect action: 'edit', id: taskInstance.getId()
	}

	@Transactional
	def activate(Task taskInstance) {
		taskInstance.setActivate(true)
		taskInstance.setUpdateTime(new Date())
		taskInstance.save flush:true
	    flash.message = message(code: 'task.activated.message', args: [taskInstance.getReq()])
		redirect action: 'edit', id: taskInstance.getId()
	}

	@Transactional
	def prev(Task taskInstance) {
		if(taskInstance.isActivate()) {
			taskInstance.setUpdateTime(new Date())
			taskService.prev(taskInstance)
			flash.message = message(code: 'default.stage.changed.message')
	        redirect action: 'edit', id: taskInstance.getId()
		} else {
			flash.error = message(code:'default.update.failed.message', 
				args:[message(code:'task.closed.message', args:[taskInstance.getReq()])])
	        redirect action: 'edit', id: taskInstance.getId()
		}
		
	}
	
	@Transactional
	def next(Task taskInstance) {
		if(taskInstance.isActivate()) {
			taskInstance.setUpdateTime(new Date())
			taskService.next(taskInstance)
			flash.message = message(code: 'default.stage.changed.message')
	        redirect action: 'edit', id: taskInstance.getId()
		} else {
			flash.error = message(code:'default.update.failed.message', 
				args:[message(code:'task.closed.message', args:[taskInstance.getReq()])])
	        redirect action: 'edit', id: taskInstance.getId()
		}
	}
	
	@Transactional
	def removeCr(Task taskInstance) {
		taskInstance.setUpdateTime(new Date())
		taskService.removeCr(taskInstance, params.cId)
		flash.message = message(code: 'default.updated.message', args: ['', taskInstance.getReq()])
        redirect action: 'edit', id: taskInstance.getId()
	}
	
	@Transactional
	def removeLog(Task taskInstance) {
		taskInstance.setUpdateTime(new Date())
		taskService.removeLog(taskInstance, params.lId)
		flash.message = message(code: 'default.updated.message', args: ['', taskInstance.getReq()])
        redirect action: 'edit', id: taskInstance.getId()
	}
	
	@Transactional
	def removeTag(Task taskInstance) {
		taskInstance.setUpdateTime(new Date())
		taskService.removeTag(taskInstance, params.tId)
		flash.message = message(code: 'default.updated.message', args: ['', taskInstance.getReq()])
        redirect action: 'edit', id: taskInstance.getId()
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
