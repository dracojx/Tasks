package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ProductController {
	def logService
	def productService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Product.list(params), model:[productInstanceCount: Product.count()]
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
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Product.label', default: 'Product'), productInstance.id])
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
