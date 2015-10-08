package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import java.text.SimpleDateFormat

import org.hibernate.Criteria
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
class TaskController {
	
	def crService
	def logService
	def taskService

    static allowedMethods = [save: "POST", update: "PUT"]

    def index() {
		params.sort = params.sort ?: 'updateDate'
		params.order = params.order ?: 'desc'
        respond Task.list(params)
    }
	
	def search() {
		def keyword = params.keyword?.trim()
		def beginDate = null
		def endDate = null
		def status = null
		def df = new SimpleDateFormat('yyyy/MM/dd')
		
		if(params.keyword) {
			for(i in 0..4) {
				def message = message(code:"task.status.$i")
				if(message.equalsIgnoreCase(keyword)) {
					status = i.toString()
					break
				}
			}
		}
		
		if(params.begin ==~ /\d{4}\/(0[1-9]|1[0-2])\/(0[1-9]|[1-3][0-9])/) {
			beginDate = df.parse(params.begin)
		}
		
		if(params.end ==~ /\d{4}\/(0[1-9]|1[0-2])\/(0[1-9]|[1-3][0-9])/) {
			endDate = df.parse(params.end)
		}
		
		if(keyword || beginDate || endDate) {
			def results = Task.withCriteria {
				order(params.sort?:'updateDate', params.order?:'desc')
				createAlias('crs', 'c', CriteriaSpecification.LEFT_JOIN)
				createAlias('tags', 't', CriteriaSpecification.LEFT_JOIN)
				createAlias('logs', 'l', CriteriaSpecification.LEFT_JOIN)
				setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				and {
					if(keyword) {
						or {
							ilike('req', "%$keyword%")
							ilike('title', "%$keyword%")
							ilike('remark', "%$keyword%")
							ilike('c.number', keyword)
							ilike('t.name', keyword)
							eq('l.product', Product.findByItemIdIlike(keyword))
							eq('user', User.findByNameIlike(keyword))
							if(status) {
								eq('status', status)
							}
						}
					}
					if(beginDate && !endDate) {
						ge('updateDate', beginDate)
					} else if(beginDate && endDate) {
						between('updateDate', beginDate, endDate + 1)
					} else if(!beginDate && endDate) {
						lt('updateDate', endDate + 1)
					}
				}
			}
			render view:'index', model:[taskInstanceList: results, action: 'search', keyword: keyword, begin: params.begin, end: params.end]
		} else {
			respond Task.list(params), [view:'index']
		}
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
		
		taskInstance.setStatus('0')
		taskInstance.setUser(User.get(session.userId))
		taskInstance.setCreateDate(new Date())
		taskInstance.setUpdateDate(taskInstance.getCreateDate())
		taskInstance.validate()
		
        if (taskInstance.hasErrors()) {
			taskInstance.setStatus(null)
			taskInstance.setUser(null)
			taskInstance.setCreateDate(null)
			taskInstance.setUpdateDate(null)
            respond taskInstance.errors, view:'create'
            return
        }
		def logs = taskService.save(params, taskInstance)

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
		
		taskInstance.setUpdateDate(new Date())
		taskInstance.validate()
        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view:'edit'
            return
        }
		
		def logs = taskService.save(params, taskInstance)
		
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
		taskInstance.setUpdateDate(new Date())
		taskInstance.save flush:true
	    flash.message = message(code: 'default.deactivated.message', args: [taskInstance.getReq()])
		redirect action: 'edit', id: taskInstance.getId()
	}

	@Transactional
	def activate(Task taskInstance) {
		taskInstance.setActivate(true)
		taskInstance.setUpdateDate(new Date())
		taskInstance.save flush:true
	    flash.message = message(code: 'default.activated.message', args: [taskInstance.getReq()])
		redirect action: 'edit', id: taskInstance.getId()
	}

	@Transactional
	def prev(Task taskInstance) {
		if(taskInstance.isActivate()) {
			taskInstance.setUpdateDate(new Date())
			taskService.prev(taskInstance)
			flash.message = message(code: 'default.stage.changed.message')
	        redirect action: 'edit', id: taskInstance.getId()
		} else {
			flash.errors = [message(code:'default.update.failed.message', 
				args:[message(code:'default.deactivated.message', args:[taskInstance.getReq()])])]
	        redirect action: 'edit', id: taskInstance.getId()
		}
		
	}
	
	@Transactional
	def next(Task taskInstance) {
		if(taskInstance.isActivate()) {
			taskInstance.setUpdateDate(new Date())
			taskService.next(taskInstance)
			flash.message = message(code: 'default.stage.changed.message')
	        redirect action: 'edit', id: taskInstance.getId()
		} else {
			flash.errors = [message(code:'default.update.failed.message', 
				args:[message(code:'default.deactivated.message', args:[taskInstance.getReq()])])]
	        redirect action: 'edit', id: taskInstance.getId()
		}
	}
	
	@Transactional
	def changeLogType(Task taskInstance) {
		taskInstance.setUpdateDate(new Date())
		logService.changeLogType(params.lId)
		taskInstance.save flush:true
		flash.message = message(code: 'default.updated.message', args: ['', taskInstance.getReq()])
        redirect action: 'edit', id: taskInstance.getId()
	}
	
	@Transactional
	def removeCr(Task taskInstance) {
		taskInstance.setUpdateDate(new Date())
		taskService.removeCr(taskInstance, params.cId)
		flash.message = message(code: 'default.updated.message', args: ['', taskInstance.getReq()])
        redirect action: 'edit', id: taskInstance.getId()
	}
	
	@Transactional
	def removeLog(Task taskInstance) {
		taskInstance.setUpdateDate(new Date())
		taskService.removeLog(taskInstance, params.lId)
		flash.message = message(code: 'default.updated.message', args: ['', taskInstance.getReq()])
        redirect action: 'edit', id: taskInstance.getId()
	}
	
	@Transactional
	def removeTag(Task taskInstance) {
		taskInstance.setUpdateDate(new Date())
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
