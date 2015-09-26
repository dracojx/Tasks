package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ReqController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Req.list(params), model:[reqInstanceCount: Req.count()]
    }

    def show(Req reqInstance) {
        respond reqInstance
    }

    def create() {
        respond new Req(params)
    }

    @Transactional
    def save(Req reqInstance) {
        if (reqInstance == null) {
            notFound()
            return
        }

        if (reqInstance.hasErrors()) {
            respond reqInstance.errors, view:'create'
            return
        }

        reqInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'req.label', default: 'Req'), reqInstance.id])
                redirect reqInstance
            }
            '*' { respond reqInstance, [status: CREATED] }
        }
    }

    def edit(Req reqInstance) {
        respond reqInstance
    }

    @Transactional
    def update(Req reqInstance) {
        if (reqInstance == null) {
            notFound()
            return
        }

        if (reqInstance.hasErrors()) {
            respond reqInstance.errors, view:'edit'
            return
        }

        reqInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Req.label', default: 'Req'), reqInstance.id])
                redirect reqInstance
            }
            '*'{ respond reqInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Req reqInstance) {

        if (reqInstance == null) {
            notFound()
            return
        }

        reqInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Req.label', default: 'Req'), reqInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'req.label', default: 'Req'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
