package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import org.hibernate.Criteria
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
class CrController {
	def crService

    static allowedMethods = [save: "POST", update: "PUT", delete: "PUT"]

    def index() {
		params.sort = params.sort ?: 'number'
		params.order = params.order ?: 'desc'
        respond Cr.list(params)
    }
	
	def search() {
		if(params.keyword?.trim()) {
			def keyword = params.keyword.trim()
			def results = Cr.withCriteria {
				order(params.sort?:'number', params.order?:'desc')
				createAlias('products', 'p', CriteriaSpecification.LEFT_JOIN)
				setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				or {
					ilike('number', "%$keyword%")
					ilike('description', "%$keyword%")
					ilike('p.itemId', keyword)
				}
			}
			render view:'index', model:[crInstanceList: results, action: 'search', keyword: keyword]
		} else {
			respond Cr.list(params), [view:'index']
		}
	}

    def show(Cr crInstance) {
        respond crInstance
    }

    def create() {
        respond new Cr(params)
    }

    @Transactional
    def save(Cr crInstance) {
        if (crInstance == null) {
            notFound()
            return
        }

        if (crInstance.hasErrors()) {
            respond crInstance.errors, view:'create'
            return
        }
		
		def products = crService.save(params, crInstance)
		
        crInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: ['', crInstance.getNumber()])
                redirect action:"edit", id: crInstance.getId()
            }
            '*' { respond crInstance, [status: CREATED] }
        }
    }

    def edit(Cr crInstance) {
        respond crInstance
    }

    @Transactional
    def update(Cr crInstance) {
        if (crInstance == null) {
            notFound()
            return
        }

        if (crInstance.hasErrors()) {
            respond crInstance.errors, view:'edit'
            return
        }
		
		def products = crService.save(params, crInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: ['', crInstance.getNumber()])
                redirect action:'edit', id: crInstance.getId()
            }
            '*'{ respond crInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Cr crInstance) {
        if (crInstance == null) {
            notFound()
            return
        }
		
		crService.delete(crInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: ['', crInstance.getNumber()])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
	
	@Transactional
	def prev(Cr crInstance) {
		crService.prev(crInstance)
        flash.message = message(code: 'default.updated.message', args: ['', crInstance.getNumber()])
		redirect action:"edit", id:crInstance.getId()
	}
	
	@Transactional
	def next(Cr crInstance) {
		crService.next(crInstance)
        flash.message = message(code: 'default.updated.message', args: ['', crInstance.getNumber()])
		redirect action:"edit", id:crInstance.getId()
	}
	
	@Transactional
	def removeProduct(Cr crInstance) {
		crService.removeProduct(crInstance, params.pId)
        flash.message = message(code: 'default.updated.message', args: ['', crInstance.getNumber()])
		redirect action:"edit", id:crInstance.getId()
	}

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cr.label', default: 'Cr'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
