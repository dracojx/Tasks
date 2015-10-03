package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ServiceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "PUT"]
	
    def index() {
		params.sort = params.sort ?: 'name'
		params.order = params.order ?: 'asc'
        respond Service.list(params)
    }
	
	def search() {
		if(params.keyword?.trim()) {
			def keyword = params.keyword.trim()
			def results = Service.withCriteria {
				order(params.sort?:'name', params.order?:'asc')
				or {
					ilike('name', "%$keyword%")
					ilike('description', "%$keyword%")
					ilike('vendor', "%$keyword%")
				}
			}
			render view:'index', model:[serviceInstanceList: results, action: 'search', keyword: keyword]
		} else {
			redirect action: 'index', params: [sort: params.sort, order: params.order]
		}
	}

    def show(Service serviceInstance) {
        respond serviceInstance
    }

    def create() {
        respond new Service(params)
    }

    @Transactional
    def save(Service serviceInstance) {
        if (serviceInstance == null) {
            notFound()
            return
        }

        if (serviceInstance.hasErrors()) {
            respond serviceInstance.errors, view:'create'
            return
        }

        serviceInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: ['', serviceInstance.getName()])
                redirect action:"edit", id: serviceInstance.getId()
            }
            '*' { respond serviceInstance, [status: CREATED] }
        }
    }

    def edit(Service serviceInstance) {
        respond serviceInstance
    }

    @Transactional
    def update(Service serviceInstance) {
        if (serviceInstance == null) {
            notFound()
            return
        }

        if (serviceInstance.hasErrors()) {
            respond serviceInstance.errors, view:'edit'
            return
        }

        serviceInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: ['', serviceInstance.getName()])
                redirect action:"edit", id: serviceInstance.getId()
            }
            '*'{ respond serviceInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Service serviceInstance) {

        if (serviceInstance == null) {
            notFound()
            return
        }

        serviceInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: ['', serviceInstance.getName()])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'service.label', default: 'Service'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
