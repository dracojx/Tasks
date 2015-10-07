package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdapterController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "PUT"]

    def index() {
		params.sort = params.sort ?: 'name'
		params.order = params.order ?: 'asc'
        respond Adapter.list(params)
    }
	
	def search() {
		if(params.keyword?.trim()) {
			def keyword = params.keyword.trim()
			def results = Adapter.withCriteria {
				order(params.sort?:'name', params.order?:'asc')
				ilike('name', "%$keyword%")
			}
			render view:'index', model:[adapterInstanceList: results, action: 'search', keyword: keyword]
		} else {
			respond Adapter.list(params), [view:'index']
		}
	}

    def show(Adapter adapterInstance) {
        respond adapterInstance
    }

    def create() {
        respond new Adapter(params)
    }

    @Transactional
    def save(Adapter adapterInstance) {
        if (adapterInstance == null) {
            notFound()
            return
        }

        if (adapterInstance.hasErrors()) {
            respond adapterInstance.errors, view:'create'
            return
        }

        adapterInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: ['', adapterInstance.getName()])
                redirect action:"edit", id: adapterInstance.getId()
            }
            '*' { respond adapterInstance, [status: CREATED] }
        }
    }

    def edit(Adapter adapterInstance) {
        respond adapterInstance
    }

    @Transactional
    def update(Adapter adapterInstance) {
        if (adapterInstance == null) {
            notFound()
            return
        }

        if (adapterInstance.hasErrors()) {
            respond adapterInstance.errors, view:'edit'
            return
        }

        adapterInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: ['', adapterInstance.getName()])
                redirect action:"edit", id: adapterInstance.getId()
            }
            '*'{ respond adapterInstance, [status: OK] }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'adapter.label', default: 'Adapter'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
