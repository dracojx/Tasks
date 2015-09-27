package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CrController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Cr.list(params), model:[crInstanceCount: Cr.count()]
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

        crInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cr.label', default: 'Cr'), crInstance.id])
                redirect crInstance
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

        crInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Cr.label', default: 'Cr'), crInstance.id])
                redirect crInstance
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

        crInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Cr.label', default: 'Cr'), crInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
