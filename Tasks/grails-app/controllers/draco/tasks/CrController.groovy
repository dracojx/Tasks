package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CrController {
	def crService

    static allowedMethods = [save: "POST", update: "PUT", delete: "PUT"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Cr.list(params), model:[crInstanceCount: Cr.count()]
    }
	
	def search() {
		if(params.keyword?.trim()) {
			def keyword = params.keyword.trim()
//			def result1 = Cr.where {
//				products.size() == 0 && 
//				(
//					number =~ "%$keyword%" || 
//					description =~ "%$keyword%"
//				)
//			}
//			def result2 = Cr.where {
//				products.size() > 0 && 
//				(
//					number =~ "%$keyword%" || 
//					description =~ "%$keyword%" || 
//					products {itemId =~ keyword}
//				)
//			}
//			def results = []
//			results.addAll(result1.toList())
//			results.addAll(result2.toList())
			def results = Cr.where {
				products {itemId == keyword} || 
				number == keyword
			}
			render view:'index', model:[crInstanceList: results, crInstanceCount: results.size(), action: 'search', keyword: keyword]
		} else {
			redirect action: 'index'
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
