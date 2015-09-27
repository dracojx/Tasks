package draco.tasks



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class LogController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Log.list(params), model:[logInstanceCount: Log.count()]
    }

    def show(Log logInstance) {
        respond logInstance
    }

    def create() {
        respond new Log(params)
    }

    @Transactional
    def save(Log logInstance) {
        if (logInstance == null) {
            notFound()
            return
        }

        if (logInstance.hasErrors()) {
            respond logInstance.errors, view:'create'
            return
        }

        logInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'log.label', default: 'Log'), logInstance.id])
                redirect logInstance
            }
            '*' { respond logInstance, [status: CREATED] }
        }
    }

    def edit(Log logInstance) {
        respond logInstance
    }

    @Transactional
    def update(Log logInstance) {
        if (logInstance == null) {
            notFound()
            return
        }

        if (logInstance.hasErrors()) {
            respond logInstance.errors, view:'edit'
            return
        }

        logInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Log.label', default: 'Log'), logInstance.id])
                redirect logInstance
            }
            '*'{ respond logInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Log logInstance) {

        if (logInstance == null) {
            notFound()
            return
        }

        logInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Log.label', default: 'Log'), logInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'log.label', default: 'Log'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
