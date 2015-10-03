package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import org.hibernate.Criteria
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
class ProductController {
	def logService
	def productService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def beforeInterceptor = {
		println "=================="
		params.entrySet().each { 
			println it
		}
		println "=================="
	}


    def index() {
		params.sort = params.sort ?: 'itemId'
		params.order = params.order ?: 'asc'
        respond Product.list(params)
    }
	
	def search() {
		if(params.keyword?.trim()) {
			def keyword = params.keyword.trim()
			def results = Product.withCriteria {
				order(params.sort?:'itemId', params.order?:'asc')
				createAlias('tags', 't', CriteriaSpecification.LEFT_JOIN)
				createAlias('logs', 'l', CriteriaSpecification.LEFT_JOIN)
				setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				or {
					ilike('itemId', "%$keyword%")
					ilike('title', "%$keyword%")
					ilike('remark', "%$keyword%")
					ilike('t.name', keyword)
					eq('sender', Service.findByNameIlike(keyword))
					eq('receiver', Service.findByNameIlike(keyword))
					eq('source', Adapter.findByNameIlike(keyword))
					eq('target', Adapter.findByNameIlike(keyword))
					eq('l.task', Task.findByReqIlike(keyword))
				}
			}
			render view:'index', model:[productInstanceList: results, action: 'search', keyword: keyword]
		} else {
			respond Product.list(params), [view:'index']
		}
	}

    def show(Product productInstance) {
        respond productInstance
    }

    def create() {
        respond new Product(params)
    }

    @Transactional
    def save(Product productInstance) {
        if (productInstance == null) {
            notFound()
            return
        }

        if (productInstance.hasErrors()) {
            respond productInstance.errors, view:'create'
            return
        }
		
		productService.save(params, productInstance, session.userId)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: ['', productInstance.getItemId()])
                redirect action: 'edit', id: productInstance.getId()
            }
            '*' { respond productInstance, [status: CREATED] }
        }
    }

    @Transactional
	def copy(Product productInstance) {
		def fields = [
			'itemId':		productInstance.getItemId(),
			'title':		productInstance.getTitle(),
			'remark':		productInstance.getRemark(),
			'mode':			productInstance.getMode(),
			'sender.id':	productInstance.getSender()?.getId(),
			'receiver.id':	productInstance.getReceiver()?.getId(),
			'source.id':	productInstance.getSource()?.getId(),
			'target.id':	productInstance.getTarget()?.getId(),
			'tags':			[] as SortedSet
			]
		productInstance.getTags().each {
			fields.tags.add(it.getId())
		}
		redirect action: 'create', params: fields
	}

	def edit(Product productInstance) {
        respond productInstance
    }
	
    @Transactional
    def update(Product productInstance) {
        if (productInstance == null) {
            notFound()
            return
        }

        if (productInstance.hasErrors()) {
            respond productInstance.errors, view:'edit'
            return
        }
		
		productService.save(params, productInstance, session.userId)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: ['', productInstance.getItemId()])
                redirect action: 'edit', id: productInstance.getId()
            }
            '*'{ respond productInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Product productInstance) {

        if (productInstance == null) {
            notFound()
            return
        }

        productInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: ['', productInstance.getItemId()])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
	def removeLog(Product productInstance) {
		productService.removeLog(productInstance, params.lId)
        flash.message = message(code: 'default.updated.message', args: ['', productInstance.getItemId()])
		redirect action: 'edit', id: productInstance.getId()
	}

    @Transactional
	def removeTag(Product productInstance) {
		productService.removeTag(productInstance, params.tId)
        flash.message = message(code: 'default.updated.message', args: ['', productInstance.getItemId()])
		redirect action: 'edit', id: productInstance.getId()
	}

	@Transactional
	def activate(Product productInstance) {
		productInstance.setActivate(true)
		productInstance.save flush:true
	    flash.message = message(code: 'default.updated.message', args: ['', productInstance.getItemId()])
		redirect action: 'edit', id: productInstance.getId()
	}

	@Transactional
	def deactivate(Product productInstance) {
		productInstance.setActivate(false)
		productInstance.save flush:true
        flash.message = message(code: 'default.updated.message', args: ['', productInstance.getItemId()])
		redirect action: 'edit', id: productInstance.getId()
	}

	protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
