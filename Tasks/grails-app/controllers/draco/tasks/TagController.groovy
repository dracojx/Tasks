package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TagController {
	
	def tagService

    static allowedMethods = [save: "POST", update: "PUT", delete: "PUT"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Tag.list(params), model:[tagInstanceCount: Tag.count()]
    }
	
	def search() {
		if(params.keyword?.trim()) {
			def keyword = params.keyword.trim()
			def results = Tag.withCriteria {
				order(params.sort?:'name', params.order?:'asc')
				ilike('name', "%$keyword%")
			}
			render view:'index', model:[tagInstanceList: results, tagInstanceCount: results.size(), action: 'search', keyword: keyword]
		} else {
			redirect action: 'index'
		}
	}

    def show(Tag tagInstance) {
        respond tagInstance
    }

    def create() {
        respond new Tag(params)
    }

    @Transactional
    def save(Tag tagInstance) {
        if (tagInstance == null) {
            notFound()
            return
        }

        if (tagInstance.hasErrors()) {
            respond tagInstance.errors, view:'create'
            return
        }

        tagInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: ['', tagInstance.getName()])
                redirect action: 'edit', id: tagInstance.getId()
            }
            '*' { respond tagInstance, [status: CREATED] }
        }
    }

    def edit(Tag tagInstance) {
        respond tagInstance
    }

    @Transactional
    def update(Tag tagInstance) {
        if (tagInstance == null) {
            notFound()
            return
        }

        if (tagInstance.hasErrors()) {
            respond tagInstance.errors, view:'edit'
            return
        }

        tagInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: ['', tagInstance.getName()])
                redirect action: 'edit', id: tagInstance.getId()
            }
            '*'{ respond tagInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Tag tagInstance) {

        if (tagInstance == null) {
            notFound()
            return
        }
		
		tagService.delete(tagInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: ['', tagInstance.getName()])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tag.label', default: 'Tag'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
